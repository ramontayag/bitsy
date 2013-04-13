class TransactionCreator

  include ClassToInstanceConvenienceMethods


  def initialize(bit_wallet_transaction)
    @bit_wallet_transaction = bit_wallet_transaction
  end

  def create
    payment_depot = PaymentDepot.find_by_address(@bit_wallet_transaction.address)
    payment_transaction = PaymentTransaction.create(
      payment_depot_id: payment_depot.id,
      amount: @bit_wallet_transaction.amount,
      receiving_address: @bit_wallet_transaction.address,
      transaction_id: @bit_wallet_transaction.id,
      confirmations: @bit_wallet_transaction.confirmations,
      category: @bit_wallet_transaction.category,
      occurred_at: @bit_wallet_transaction.occurred_at,
      received_at: @bit_wallet_transaction.received_at
    )
    if payment_transaction
      @bit_wallet_transaction.wallet.move(
        payment_depot.id.to_s,
        '',
        @bit_wallet_transaction.amount
      )
    end
  end

end
