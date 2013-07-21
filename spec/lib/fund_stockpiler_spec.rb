require 'spec_helper'

describe FundStockpiler do

  describe '#stockpile' do
    let(:wallet) { double }

    context 'payment_transaction is not nil' do
      context 'payment_transaction#payment_type is "recieve"' do
        let(:payment_transaction) do
          build_stubbed(:payment_transaction,
                        payment_type: 'receive',
                        receiving_address: 'rumplestiltskin',
                        amount: 2.21)
        end

        let(:payment_depot) do
          payment_depot = build_stubbed(:payment_depot)
          PaymentDepot.stub(:find_by_address).with('rumplestiltskin').
            and_return(payment_depot)
          payment_depot
        end

        it 'should move funds to the master account' do
          stockpiler = described_class.new(wallet, payment_transaction)

          wallet.should_receive(:move).with(payment_depot.bitcoin_account_name,
                                            App.bitcoin_master_account_name,
                                            2.21)

          stockpiler.stockpile
        end
      end

      context 'payment_transaction is not "receive"' do
        it 'should not move funds' do
          payment_transaction = build_stubbed(:payment_transaction,
                                              payment_type: 'send')
          stockpiler = described_class.new(wallet, payment_transaction)
          wallet.should_not_receive(:move)
          stockpiler.stockpile
        end
      end
    end

    context 'payment_transaction is nil' do
      it 'should not move funds' do
        stockpiler = described_class.new(wallet, nil)
        wallet.should_not_receive(:move)
        stockpiler.stockpile
      end
    end
  end

end
