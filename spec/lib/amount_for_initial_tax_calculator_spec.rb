require 'spec_helper'

describe AmountForInitialTaxCalculator do

  describe '#calculate(payment, minimum_payment, total_received_amount)' do
    context 'when the total received amount is <= the minimum payment' do
      it 'should return the payment' do
        calculator = described_class.new(0.8, 1, 0.8)
        calculator.calculate.should == 0.8

        calculator = described_class.new(0.7, 1, 0.7)
        calculator.calculate.should == 0.7
      end
    end

    context 'when the total_received_amount is > the min_payment' do
      context 'amount received prior to current payment is <= minimum payment' do
        it 'should return the amount of the given payment that is subject to the initial tax rate' do
          # Received 0.8 before
          calculator = described_class.new(7.2, 1.0, 8.0)
          calculator.calculate.round(1).should == 0.2
        end
      end

      context 'amount received prior to current payment is > the minimum payment' do
        it 'should return the amount of the given payment that is subject to the initial tax rate' do
          # Received 1.5 before
          calculator = described_class.new(2.2, 1.0, 3.7)
          calculator.calculate.round(1).should == 0.0
        end
      end
    end
  end

end
