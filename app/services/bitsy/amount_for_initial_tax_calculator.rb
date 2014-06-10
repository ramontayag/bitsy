module Bitsy
  class AmountForInitialTaxCalculator

    def self.calculate(payment, min_payment, total_received_amount)
      if total_received_amount < payment
        fail ArgumentError, "total amount recieved (#{total_received_amount}) cannot possibly be lower than the payment (#{payment}))"
      elsif total_received_amount > min_payment
        total_received_prior_to_payment = total_received_amount - payment
        amount = min_payment - total_received_prior_to_payment
        return 0 if amount < 0
        amount
      else
        payment
      end
    end

  end
end
