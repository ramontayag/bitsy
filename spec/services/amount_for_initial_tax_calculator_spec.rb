require 'spec_helper'

module Bitsy
  describe AmountForInitialTaxCalculator do

    describe '#calculate(payment, minimum_payment, total_received_amount)' do
      context 'when the total received amount is <= the minimum payment' do
        it 'returns the payment' do
          resulting_value = described_class.calculate(0.8, 1, 0.8)
          expect(resulting_value).to eq 0.8

          resulting_value = described_class.calculate(0.7, 1, 0.7)
          expect(resulting_value).to eq 0.7
        end
      end

      context 'when the total_received_amount is > the min_payment' do
        context 'amount received prior to current payment is <= minimum payment' do
          it 'returns the amount of the given payment that is subject to the initial tax rate' do
            # Received 0.8 before
            resulting_value = described_class.calculate(7.2, 1.0, 8.0)
            expect(resulting_value.round(1)).to eq 0.2
          end
        end

        context 'amount received prior to current payment is > the minimum payment' do
          it 'returns the amount of the given payment that is subject to the initial tax rate' do
            # Received 1.5 before
            resulting_value = described_class.calculate(2.2, 1.0, 3.7)
            expect(resulting_value.round(1)).to eq 0.0
          end
        end
      end
    end

  end
end
