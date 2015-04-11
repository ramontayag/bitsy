require 'securerandom'

module Bitsy
  class PaymentDepot < ActiveRecord::Base

    has_many :transactions, class_name: 'PaymentTransaction'

    alias_attribute :balance, :balance_cache
    after_initialize :set_uuid
    scope :with_balance, -> { where('balance_cache > 0.0') }
    scope :checked_at_is_past_or_nil, -> do
      checked_at = arel_table[:checked_at]
      where(checked_at.lt(Time.now).or(checked_at.eq(nil)))
    end
    scope :received_at_least_minimum, -> do
      min_payment = arel_table[:min_payment]
      total_received_amount_cache = arel_table[:total_received_amount_cache]
      where(min_payment.lteq(total_received_amount_cache))
    end
    scope :within_check_count_threshold, -> do
      where(arel_table[:check_count].lt(Bitsy.config.check_limit))
    end
    scope :for_manual_checking, -> do
      checked_at_is_past_or_nil.received_at_least_minimum.
        within_check_count_threshold
    end
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

    def reset_checked_at!
      self.update_attributes(
        check_count: self.check_count + 1,
        checked_at: (self.check_count**2).seconds.from_now,
      )
    end

    def balance_tax_amount
      ForwardTaxCalculator.calculate(self.balance,
                                     self.min_payment,
                                     self.total_received_amount,
                                     self.initial_tax_rate,
                                     self.added_tax_rate)
    end

    def total_received_amount
      read_attribute :total_received_amount_cache
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

    def forwarding_transaction_fee
      total_received_amount - total_tax_sent - total_owner_sent
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
