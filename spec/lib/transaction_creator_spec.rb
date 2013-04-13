require 'spec_helper'

describe TransactionCreator do

  describe '#create' do
    context 'when transaction was successfully created' do
      it 'should create the transaction and move the funds' do
        wallet = double
        bw_transaction = build(:bit_wallet_transaction,
                               address: 'rumplestiltskin',
                               id: 'txid',
                               occurred_at: Time.at(1365328873),
                               received_at: Time.at(1365328875),
                               category: 'receive',
                               amount: 2.12,
                               confirmations: 2,
                               wallet: wallet)
        payment_depot = build_stubbed(:payment_depot)
        PaymentDepot.stub(:find_by_address).with(bw_transaction.address).
          and_return(payment_depot)

        PaymentTransaction.should_receive(:create).with(hash_including(
          payment_depot_id: payment_depot.id,
          amount: 2.12,
          receiving_address: 'rumplestiltskin',
          transaction_id: 'txid',
          confirmations: 2,
          category: 'receive',
          occurred_at: Time.at(1365328873),
          received_at: Time.at(1365328875)
        )).and_return(true)

        wallet.should_receive(:move).with(payment_depot.id.to_s, '', 2.12)

        creator = described_class.new(bw_transaction)
        creator.create
      end
    end

    context 'when the transaction failed to be created' do
      it 'should not move the funds' do
        wallet = double
        bw_transaction = build(:bit_wallet_transaction,
                               address: 'rumplestiltskin',
                               id: 'txid',
                               occurred_at: Time.at(1365328873),
                               received_at: Time.at(1365328875),
                               category: 'receive',
                               amount: 2.12,
                               confirmations: 2,
                               wallet: wallet)
        payment_depot = build_stubbed(:payment_depot)
        PaymentDepot.stub(:find_by_address).with(bw_transaction.address).
          and_return(payment_depot)

        PaymentTransaction.should_receive(:create).with(hash_including(
          payment_depot_id: payment_depot.id,
          amount: 2.12,
          receiving_address: 'rumplestiltskin',
          transaction_id: 'txid',
          confirmations: 2,
          category: 'receive',
          occurred_at: Time.at(1365328873),
          received_at: Time.at(1365328875)
        )).and_return(false)

        wallet.should_not_receive(:move)

        creator = described_class.new(bw_transaction)
        creator.create
      end
    end
  end

end
