class FundStockpiler
  include ClassToInstanceConvenienceMethods

  def initialize(wallet, payment_transaction)
    @wallet = wallet
    @payment_transaction = payment_transaction
  end

  def stockpile
    if received_payment?(@payment_transaction)
      @wallet.move(
        payment_depot.bitcoin_account_name,
        App.bitcoin_master_account_name,
        @payment_transaction.amount.to_f
      )
    end
  end

  private

  def received_payment?(pt)
    pt && pt.payment_type == 'recieve'
  end

  def payment_depot
    @payment_depot ||= PaymentDepot.
      find_by_address(@payment_transaction.receiving_address)
  end

end
