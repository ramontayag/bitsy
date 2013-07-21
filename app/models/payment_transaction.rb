class PaymentTransaction < ActiveRecord::Base
  attr_accessible(:amount,
                  :payment_depot_id,
                  :receiving_address,
                  :sending_address,
                  :transaction_id,
                  :confirmations,
                  :payment_type,
                  :occurred_at,
                  :received_at)

  belongs_to :payment_depot

  scope :safely_confirmed, -> {
    column_name = "#{self.table_name}.confirmations"
    where("#{column_name} >= #{App.safe_confirmation_threshold}")
  }
  scope :forwarded, -> {
    where("#{self.table_name}.forwarding_transaction_id IS NOT NULL")
  }
  scope :not_forwarded, -> {
    where("#{self.table_name}.forwarding_transaction_id IS NULL")
  }
  scope :received, -> { where(payment_type: 'receive') }
  scope :received_by, lambda { |address| where(receiving_address: address) }
  scope :sent_by, lambda { |address| where(sending_address: address) }
  scope :tax, lambda { where(payment_type: 'tax') }
  scope :non_tax, lambda { where('payment_type != ?', 'tax') }

  delegate :min_payment, to: :payment_depot, prefix: true
  delegate :balance, to: :payment_depot, prefix: true
  delegate :initial_tax_rate, to: :payment_depot, prefix: true
  delegate :added_tax_rate, to: :payment_depot, prefix: true

  def forward_tax_fee
    binding.pry
    ForwardTaxCalculator.calculate(self.amount,
                                   self.payment_depot_min_payment,
                                   self.payment_depot_balance,
                                   self.payment_depot_initial_tax_rate,
                                   self.payment_depot_added_tax_rate)
  end

  def owner_fee
    self.amount - self.forward_tax_fee
  end
end
