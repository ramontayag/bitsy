class TransactionCreator

  include ClassToInstanceConvenienceMethods


  def initialize(bit_wallet_transaction)
    @bit_wallet_transaction = bit_wallet_transaction
  end

  def create
    return false if payment_depot.nil?
    payment_transaction = PaymentTransaction.create(
      payment_depot_id: payment_depot.id,
      amount: @bit_wallet_transaction.amount,
      receiving_address: @bit_wallet_transaction.address_str,
      transaction_id: @bit_wallet_transaction.id,
      confirmations: @bit_wallet_transaction.confirmations,
      payment_type: @bit_wallet_transaction.category,
      occurred_at: @bit_wallet_transaction.occurred_at,
      received_at: @bit_wallet_transaction.received_at
    )
    move_funds_for payment_transaction
  end

  private

  def move_funds_for(payment_transaction)
    FundStockpiler.stockpile(@bit_wallet_transaction.wallet, payment_transaction)
  end

  def payment_depot
    @payment_depot ||= PaymentDepot.
      find_by_address(@bit_wallet_transaction.address_str)
  end

end
