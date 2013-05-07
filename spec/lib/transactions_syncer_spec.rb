require 'spec_helper'

describe TransactionsSyncer do

  describe '#sync' do
    context 'when the transaction already exists' do
      it 'should delegate the work the the transaction updater' do
        bw_transaction = build(:bit_wallet_transaction,
                               id: 'txid',
                               address: 'rumplestiltskin',
                               amount: 2.13,
                               occurred_at: Time.at(1365328873),
                               received_at: Time.at(1365328875))
        bw_transactions = [bw_transaction]
        wallet = double(recent_transactions: bw_transactions)

        payment_transaction = build_stubbed(:payment_transaction)
        PaymentTransaction.stub(:where).with(hash_including(
          transaction_id: 'txid',
          receiving_address: 'rumplestiltskin',
          amount: 2.13,
          occurred_at: Time.at(1365328873),
          received_at: Time.at(1365328875)
        )).and_return([payment_transaction])

        TransactionUpdater.should_receive(:update).
          with(payment_transaction, bw_transaction)

        syncer = described_class.new(wallet)
        syncer.sync
      end
    end

    context 'when the transaction does not exist' do
      it 'should delegate the work to the transaction creator' do
        bw_transaction = build(:bit_wallet_transaction)
        bw_transactions = [bw_transaction]
        wallet = double(recent_transactions: bw_transactions)
        TransactionCreator.should_receive(:create).with(bw_transaction)
        syncer = described_class.new(wallet)
        syncer.sync
      end
    end
  end

end
