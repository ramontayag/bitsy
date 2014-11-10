require 'securerandom'

module Bitsy
  class PaymentDepot < ActiveRecord::Base
    has_many :transactions, class_name: 'PaymentTransaction'

    alias_attribute :balance, :balance_cache
    after_initialize :set_uuid
    scope :with_balance, -> { where('balance_cache > 0.0') }
    validates(
      :initial_tax_rate,
      inclusion: {
        in: 0.0..1.0,
        message: 'must be a value within 0.0 and 1.0'
      }
    )
    validates :address, presence: true, uniqueness: true
    validates :balance_cache, presence: true
    validates :owner_address, presence: true
    validates :tax_address, presence: true
    validates :uuid, uniqueness: true, presence: true

    def initial_owner_rate
      self.min_payment * (1 - self.initial_tax_rate)
    end

    def balance_tax_amount
      ForwardTaxCalculator.calculate(self.balance,
                                     self.min_payment,
                                     self.total_received_amount,
                                     self.initial_tax_rate,
                                     self.added_tax_rate)
    end

    def total_received_amount
      self.transactions.credits.sum(:amount)
    end

    def total_tax_sent
      tax_transactions.sum(:amount).abs
    end

    def total_owner_sent
      owner_transactions.sum(:amount).abs
    end

    def min_payment_received?
      self.total_received_amount >= self.min_payment
    end

    def initial_fee_received
      if min_payment_received?
        self.min_payment
      else
        self.total_received_amount
      end
    end

    def added_fee_received
      if min_payment_received?
        self.total_received_amount - self.min_payment
      else
        0.0
      end
    end

    def initial_tax_amount
      initial_fee_received * self.initial_tax_fee
    end

    def added_tax_amount
      added_fee_received * self.added_tax_fee
    end

    def has_balance?
      self.balance > 0
    end

    def bitcoin_account_name
      self.uuid
    end

    private

    def tax_transactions
      self.transactions.debit.tax
    end

    def owner_transactions
      self.transactions.debit.non_tax
    end

    def set_uuid
      self.uuid ||= UUIDTools::UUID.random_create.to_s
    end

  end
end
