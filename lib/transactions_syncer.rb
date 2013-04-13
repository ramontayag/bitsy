class TransactionsSyncer

  include ClassToInstanceConvenienceMethods

  def initialize(bit_wallet)
    @bit_wallet = bit_wallet
  end

  def sync
    bit_wallet_transactions.each do |tx|
      payment_transaction_args = {transaction_id: tx.id,
                                  receiving_address: tx.address,
                                  amount: tx.amount,
                                  occurred_at: tx.occurred_at,
                                  received_at: tx.received_at}
      payment_transaction = PaymentTransaction.
        where(payment_transaction_args).first
      if payment_transaction
        TransactionUpdater.update payment_transaction, tx
      else
        TransactionCreator.create tx
      end
    end
  end

  private

  def bit_wallet_transactions
    @bit_wallet.recent_transactions
  end

end
