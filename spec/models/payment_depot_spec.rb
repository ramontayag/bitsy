require 'spec_helper'

describe PaymentDepot do

  describe '#initial_tax_rate=' do
    context 'when setting to a value that not between 0 and 1' do
      it 'should raise an ArgumentError', vcr: true do
        payment_depot = build_stubbed(:payment_depot, min_payment: 1)
        error_message =  '`initial_tax_rate` must be a value between 0.0 and 1.0'
        expect { payment_depot.initial_tax_rate = 1.5 }.to raise_error(ArgumentError, error_message)
        expect { payment_depot.initial_tax_rate = 0.1 }.to_not raise_error(ArgumentError, error_message)
        expect { payment_depot.initial_tax_rate = -1.5 }.to raise_error(ArgumentError, error_message)
      end
    end
  end

  describe '#balance' do
    it 'should always update the #balance_cache field', vcr: true do
      payment_depot = build(:payment_depot)
      payment_depot.stub(:bit_wallet_account_balance).and_return(2.2)
      payment_depot.balance.should == 2.2
      payment_depot.balance_cache.should == 2.2
    end
  end

  describe '#balance_owner_amount' do
    it 'should return the part of the balance that should be sent to the owner address'
  end

  describe '#initial_owner_rate' do
    it 'should be the min_payment less than initial tax fee', vcr: true do
      payment_depot = build_stubbed(:payment_depot,
                                    min_payment: 1,
                                    initial_tax_rate: 0.4)
      payment_depot.initial_owner_rate.should == 0.6
    end
  end

  describe '#total_received_amount' do
    it 'should return the total amount received', vcr: true do
      tx1 = build_stubbed(:payment_transaction, amount: 1.2)
      tx2 = build_stubbed(:payment_transaction, amount: -1.1)
      tx3 = build_stubbed(:payment_transaction, amount: 0.5)
      credits = [tx1, tx2]
      credits.stub(:sum).with(:amount).and_return(1.2+0.5)
      payment_depot = build_stubbed(:payment_depot)
      payment_depot.stub_chain(:transactions, :credits).
        and_return(credits)
      payment_depot.total_received_amount.should == 1.7
    end
  end

  describe '#total_tax_sent' do
    it 'should return the total amount sent to the tax address', vcr: true do
      payment_depot = build_stubbed(:payment_depot)
      txs = double
      txs.stub(:sum).with(:amount).and_return(-3.7)
      payment_depot.stub(:tax_transactions).and_return(txs)
      payment_depot.total_tax_sent.should == 3.7
    end
  end

  describe '#total_owner_sent' do
    it 'should return the total amount sent to the owner address', vcr: true do
      payment_depot = build_stubbed(:payment_depot)
      txs = double
      txs.stub(:sum).with(:amount).and_return(-5.5)
      payment_depot.stub(:owner_transactions).and_return(txs)
      payment_depot.total_owner_sent.should == 5.5
    end
  end

end
