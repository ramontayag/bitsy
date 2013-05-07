require 'securerandom'

class PaymentDepot < ActiveRecord::Base
  has_many :transactions, class_name: 'PaymentTransaction'
  TAX_ADDRESS = App.tax_address

  alias_attribute :balance, :balance_cache
  delegate :balance, to: :bit_wallet_account
  scope :with_balance, -> { where('balance_cache > 0.0') }

  # def self.create_with_bitcoin_address
  #   payment_depot = self.create
  #   payment_depot.set_bitcoin_address
  # end

  def initial_owner_rate
    self.min_payment * (1 - self.initial_tax_rate)
  end

  def initial_tax_rate=(rate)
    if rate < 0.0 || rate > 1.0
      fail ArgumentError.
        new('`initial_tax_rate` must be a value between 0.0 and 1.0')
    end
    super
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

  def balance
    self.balance_cache = bit_wallet_account_balance
  end

  def has_balance?
    self.balance > 0
  end

  private

  def set_bitcoin_address
    if self.address.blank?
      self.address = bit_wallet_account.addresses.first.address
    end
  end

  def set_balance_cache
    self.balance_cache = bit_wallet_account.balance
  end

  def tax_transactions
    self.transactions.debit.tax
  end

  def owner_transactions
    self.transactions.debit.non_tax
  end

  def bit_wallet_account
    return @bit_wallet_account if @bit_wallet_account
    account_name = "#{Time.now.to_i}-#{SecureRandom.hex(32)}"
    @bit_wallet_account = bit_wallet.accounts.new(account_name)
  end

  def bit_wallet
    App.bit_wallet
  end

  def bit_wallet_account_balance
    bit_wallet_account.balance
  end

end
