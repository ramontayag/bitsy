class PaymentJob

  def self.run
    TransactionsSyncer.sync(App.bit_wallet)
    PaymentForwarder.forward
  end

end
