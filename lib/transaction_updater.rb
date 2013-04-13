class TransactionUpdater
  include ClassToInstanceConvenienceMethods

  def initialize(payment_transaction, bit_wallet_transaction)
    @payment_transaction = payment_transaction
    @bit_wallet_transaction = bit_wallet_transaction
  end

  def update
    @payment_transaction.update_attributes(
      confirmations: @bit_wallet_transaction.confirmations
    )
  end
end
