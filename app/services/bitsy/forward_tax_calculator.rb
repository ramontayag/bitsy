module Bitsy
  class ForwardTaxCalculator

    def self.calculate(payment, min_payment, total_received_amount, initial_tax_rate, added_tax_rate)
      initial_tax_amount = AmountForInitialTaxCalculator.calculate(
        payment,
        min_payment,
        total_received_amount,
      )
      initial_tax_fee = initial_tax_amount * initial_tax_rate
      amount_for_added_tax = payment - initial_tax_amount
      added_tax_fee = amount_for_added_tax * added_tax_rate
      initial_tax_fee + added_tax_fee
    end

  end
end
