class PaymentForwarder

  include ClassToInstanceConvenienceMethods

  def forward
    if payment_transactions.sum(:amount) >= App.forward_threshold
      bitcoin_master_account.send_many send_many_args
    end
  end

  private

  def send_many_args
    @send_many_args ||= payment_transactions.inject({}) do |hash, transaction|
      hash.merge(PaymentSendManyHashBuilder.build(transaction))
    end
  end

  def payment_transactions
    PaymentTransaction.safely_confirmed.not_forwarded.received
  end

  def bitcoin_master_account
    App.bitcoin_master_account
  end

end
