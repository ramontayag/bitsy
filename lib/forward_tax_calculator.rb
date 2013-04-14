class ForwardTaxCalculator

  include ClassToInstanceConvenienceMethods

  def initialize(payment, min_payment, total_received_amount, initial_tax_rate, added_tax_rate)
    @payment = payment
    @min_payment = min_payment
    @total_received_amount = total_received_amount
    @initial_tax_rate = initial_tax_rate
    @added_tax_rate = added_tax_rate
  end

  def calculate
    initial_tax_fee = amount_for_initial_tax * @initial_tax_rate
    added_tax_fee = amount_for_added_tax * @added_tax_rate
    initial_tax_fee + added_tax_fee
  end

  private

  def amount_for_initial_tax
    AmountForInitialTaxCalculator.calculate(@payment,
                                            @min_payment,
                                            @total_received_amount)
  end

  def amount_for_added_tax
    @payment - amount_for_initial_tax
  end

end
