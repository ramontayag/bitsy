require "spec_helper"

module Bitsy
  describe CheckPaymentDepotTransaction, ".execute" do

    let(:latest_block) { build(:blockchain_latest_block) }
    let(:payment_depot) { build_stubbed(:payment_depot, address: "address") }
    let(:blockchain_transaction_1) { build(:blockchain_transaction) }
    let(:blockchain_transaction_2) { build(:blockchain_transaction) }
    let(:blockchain_transactions) do
      [blockchain_transaction_1, blockchain_transaction_2]
    end
    let(:blockchain_address) do
      build(:blockchain_address, address: "address")
    end

    before do
      allow(Blockchain).to receive(:get_address).with("address").
        and_return(blockchain_address)
      allow(blockchain_address).to receive(:txs).
        and_return(blockchain_transactions)
    end

    it "checks the transactions of the payment depot" do
      blockchain_transactions.each do |tx|
        expect(ProcessBlockchainBlockexplorerTransaction).
          to receive(:execute).with(
            payment_depot: payment_depot,
            latest_block: latest_block,
            blockchain_transaction: tx,
          )
      end

      described_class.execute(
        latest_block: latest_block,
        payment_depot: payment_depot,
      )
    end

  end
end
