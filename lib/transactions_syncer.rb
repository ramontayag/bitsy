class TransactionsSyncer

  include ClassToInstanceConvenienceMethods

  def initialize(bit_wallet)
    @bit_wallet = bit_wallet
  end

  def sync
    bit_wallet_transactions.each do |tx|
      if payment_transaction = payment_transaction_for(tx)
        TransactionUpdater.update payment_transaction, tx
      else
        TransactionCreator.create tx
      end
    end
  end

  private

  def payment_transaction_for(tx)
    PaymentTransaction.matching_bit_wallet_transaction(tx).first
  end

  def bit_wallet_transactions
    @bit_wallet.recent_transactions
  end

end
