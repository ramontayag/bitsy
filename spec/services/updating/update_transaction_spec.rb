require "spec_helper" 
module Bitsy
  module Updating
    describe UpdateTransaction, ".execute" do

      let(:latest_block) { build(:blockchain_latest_block, height: 30) }
      let(:blockchain_tx) do
        build(:blockchain_transaction, block_height: block_height)
      end
      let(:tx) { build_stubbed(:payment_transaction, transaction_id: "txid") }

      before do
        allow(Blockchain).to receive(:get_tx).with("txid").
          and_return(blockchain_tx)
      end

      context "confirmed tx" do
        let(:block_height) { 29 }
        it "updates the transaction with data from blockchain" do
          expect(tx).to receive(:update_attributes).with(confirmations: 2)

          described_class.execute(
            latest_block: latest_block,
            payment_transaction: tx,
          )
        end
      end

      context "unconfirmed tx" do
        let(:block_height) { false }
        it "updates the transaction to have 0 confirmations" do
          expect(tx).to receive(:update_attributes).with(confirmations: 0)
          described_class.execute(
            latest_block: latest_block,
            payment_transaction: tx,
          )
        end
      end

    end
  end
end
