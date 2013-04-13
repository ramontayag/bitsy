class PaymentTransaction < ActiveRecord::Base
  attr_accessible(:amount,
                  :payment_depot_id,
                  :receiving_address,
                  :sending_address)

  belongs_to :payment_depot

  scope :credit, -> { where("amount >= 0") }
  scope :debit, -> { where("amount < 0") }
  scope :received_by, lambda { |address| where(receiving_address: address) }
  scope :sent_by, lambda { |address| where(sending_address: address) }
  scope :tax, lambda { where(payment_type: 'tax') }
  scope :non_tax, lambda { where('payment_type != ?', 'tax') }
end
