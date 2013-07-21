require 'spec_helper'

describe PaymentSendManyHashBuilder do

  describe '#build' do
    it 'should build a hash in the sendmany format to forward money out to tax and owner' do
      bw_transaction = build(:bit_wallet_transaction,
                             address: 'payment_address')
      payment_depot = build_stubbed(:payment_depot,
                                    address: 'payment_address',
                                    owner_address: 'owner_address',
                                    min_payment: 0.1)
      PaymentDepot.stub(:find_by_address).with('payment_address').
        and_return(payment_depot)
      payment_transaction = build_stubbed(:payment_transaction,
                                          receiving_address: 'payment_address',
                                          amount: 2.2)
      payment_transaction.stub(:forward_tax_fee).and_return(1.0)

      builder = described_class.new(payment_transaction)
      hash = builder.build

      hash.should == {
        App.tax_address => 1.0,
        'owner_address' => 1.2
      }
    end
  end

end
