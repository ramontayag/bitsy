module Bitsy
  class PaymentTransaction < ActiveRecord::Base

    belongs_to :payment_depot

    scope :safely_confirmed, -> {
      column_name = "#{self.table_name}.confirmations"
      where("#{column_name} >= #{Bitsy.config.safe_confirmation_threshold}")
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
    scope :for_forwarding, -> { safely_confirmed.not_forwarded.received }
    scope :credits, -> { received }

    delegate :min_payment, to: :payment_depot, prefix: true
    delegate :balance, to: :payment_depot, prefix: true
    delegate :initial_tax_rate, to: :payment_depot, prefix: true
    delegate :added_tax_rate, to: :payment_depot, prefix: true
    delegate :total_received_amount, to: :payment_depot, prefix: true

    after_create :update_payment_depot_cache

    def forward_tax_fee
      ForwardTaxCalculator.calculate(self.amount,
                                     self.payment_depot_min_payment,
                                     self.payment_depot_total_received_amount,
                                     self.payment_depot_initial_tax_rate,
                                     self.payment_depot_added_tax_rate)
    end

    def owner_fee
      self.amount - self.forward_tax_fee
    end

    def update_payment_depot_cache
      if payment_type == "receive"
        payment_depot.total_received_amount_cache += amount
        payment_depot.save
      end
    end

  end
end
