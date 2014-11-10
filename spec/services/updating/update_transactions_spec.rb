require "spec_helper"

module Bitsy
  module Updating
    describe UpdateTransactions, ".execute" do

      let(:tx1) { build_stubbed(:payment_transaction) }
      let(:tx2) { build_stubbed(:payment_transaction) }
      let(:txs) { [tx1, tx2] }
      let(:latest_block) { build(:blockchain_latest_block) }

      it "calls UpdateTransaction with wallet on each transaction" do
        txs.each do |tx|
          expect(UpdateTransaction).to receive(:execute).
            with(latest_block: latest_block, payment_transaction: tx)
        end

        described_class.execute(
          latest_block: latest_block,
          payment_transactions: txs,
        )
      end

    end
  end
end
