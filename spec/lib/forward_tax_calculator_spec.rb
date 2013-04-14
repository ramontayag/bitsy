require 'spec_helper'

describe ForwardTaxCalculator do

  describe '#calculate' do
    it 'should return an the correct amount that should be taxed from the payment' do
      calculator = described_class.new(0.8, 1.0, 0.8, 0.5, 0.05)
      calculator.calculate.should == 0.4

      calculator = described_class.new(1.0, 1.0, 2.0, 0.4, 0.3)
      calculator.calculate.should == 0.3

      calculator = described_class.new(2.0, 1.0, 2.0, 0.4, 0.2)
      calculator.calculate.should == 0.4 + 0.2 * 1.0

      calculator = described_class.new(1.5, 0.5, 2.5, 0.5, 0.05)
      calculator.calculate.should == 0.05 * 1.5
    end
  end
end
