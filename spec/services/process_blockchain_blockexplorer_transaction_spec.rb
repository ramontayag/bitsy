require "spec_helper"

module Bitsy
  describe ProcessBlockchainBlockexplorerTransaction, ".execute" do

    let(:latest_block) { build(:blockchain_latest_block, height: block_height) }
    let(:payment_depot) { build_stubbed(:payment_depot, address: "addr1") }
    let(:output_attrs_1) do
      attributes_for(:blockchain_output, {addr: "changeaddr", value: 21})
    end
    let(:output_attrs_2) do
      attributes_for(:blockchain_output, {addr: "addr1", value: 50})
    end
    let(:block_height) { 231 }
    let(:outputs) { [output_attrs_1, output_attrs_2] }
    let(:tx) do
      build(:blockchain_transaction, {
        hash: "tx_hash",
        out: outputs,
        block_height: block_height,
      })
    end

    context "the transaction has not been processed before" do
      it "creates a payment transaction" do
        expect(PaymentTransaction).to receive(:create!).with(
          payment_depot_id: payment_depot.id,
          amount: 50 / 100_000_000.0,
          receiving_address: "addr1",
          payment_type: "receive",
          confirmations: 1,
          transaction_id: "tx_hash",
        )

        described_class.execute(
          latest_block: latest_block,
          payment_depot: payment_depot,
          blockchain_transaction: tx,
        )
      end

      context "transaction#block_height is false" do
        let(:tx) do
          build(:blockchain_transaction, {
            hash: "tx_hash",
            out: outputs,
            block_height: false,
          })
        end
        it "creates a payment transaction with 0 height" do
          expect(PaymentTransaction).to receive(:create!).with(hash_including(
            confirmations: 0,
          ))

          described_class.execute(
            latest_block: latest_block,
            payment_depot: payment_depot,
            blockchain_transaction: tx,
          )
        end
      end
    end

    context "the transaction has been processed before" do
      it "does not create a payment transaction" do
        expect(PaymentTransaction).to receive(:exists?).
          with(transaction_id: "tx_hash").and_return(true)

        expect(PaymentTransaction).to_not receive(:create!)

        described_class.execute(
          latest_block: latest_block,
          payment_depot: payment_depot,
          blockchain_transaction: tx,
        )
      end
    end

  end
end
