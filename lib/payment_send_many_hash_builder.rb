class PaymentSendManyHashBuilder
  include ClassToInstanceConvenienceMethods

  def initialize(payment_transaction)
    @payment_transaction = payment_transaction
  end

  def build
    {
      App.tax_address => @payment_transaction.forward_tax_fee,
      payment_depot.owner_address => @payment_transaction.owner_fee
    }
  end

  private

  def payment_depot
    @payment_depot ||= PaymentDepot.
      find_by_address(@payment_transaction.receiving_address)
  end

  def forward_tax_fee
    @forward_tax_fee ||= @payment_transaction.forward_tax_fee
  end

end
