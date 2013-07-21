class FundStockpiler
  include ClassToInstanceConvenienceMethods

  def initialize(wallet, payment_transaction)
    @wallet = wallet
    @payment_transaction = payment_transaction
  end

  def stockpile
    if @payment_transaction && @payment_transaction.payment_type == 'receive'
      @wallet.move(
        payment_depot.bitcoin_account_name,
        App.bitcoin_master_account_name,
        @payment_transaction.amount.to_f
      )
    end
  end

  private

  def payment_depot
    @payment_depot ||= PaymentDepot.
      find_by_address(@payment_transaction.receiving_address)
  end

end
