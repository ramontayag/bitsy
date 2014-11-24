require "spec_helper"

module Bitsy
  describe BuildSendManyHash, ".execute" do

    let(:payment_tx_1) { build_stubbed(:payment_transaction) }
    let(:payment_tx_2) { build_stubbed(:payment_transaction) }
    let(:payment_tx_3) { build_stubbed(:payment_transaction) }

    let(:transaction_fee) { 6 }
    let(:payment_transactions) { [payment_tx_1, payment_tx_2, payment_tx_3] }
    let(:amount_for_splitting) { total_amount - transaction_fee }
    let(:total_amount) do
      (20 + 50 + 50 + 150 + 120 + 20) / 100_000_000.0
    end

    let(:payment_tx_hash_1) do
      { "addr1" => 19, "addr2" => 49 }
    end

    let(:payment_tx_hash_2) do
      { "addr1" => 49, "addr3" => 149 }
    end

    let(:payment_tx_hash_3) do
      { "addr4" => 119, "addr5" => 19 }
    end

    let(:transaction_hashes) do
      {
        payment_tx_1 => payment_tx_hash_1,
        payment_tx_2 => payment_tx_hash_2,
        payment_tx_3 => payment_tx_hash_3,
      }
    end

    let(:ctx) do
      {
        payment_transactions: payment_transactions,
        amount_for_splitting: amount_for_splitting,
        total_amount: total_amount,
      }
    end

    before do
      payment_transactions.each do |payment_transaction|
        resulting_ctx = double(LightService::Context, {
          transaction_send_many_hash: transaction_hashes[payment_transaction]
        })
        expect(BuildSendManyHashForTransaction).to receive(:execute).with(
          payment_transaction: payment_transaction,
          amount_for_splitting: amount_for_splitting,
          total_amount: total_amount,
        ).and_return(resulting_ctx)
      end
    end

    it "builds a send many hash from the amount to be split, and determines transaction fee from amount left" do
      resulting_ctx = described_class.execute(ctx)

      expect(resulting_ctx.computed_transaction_fee).to eq 6

      send_many_hash = resulting_ctx.send_many_hash

      expect(send_many_hash["addr1"]).to eq 68
      expect(send_many_hash["addr2"]).to eq 49
      expect(send_many_hash["addr3"]).to eq 149
      expect(send_many_hash["addr4"]).to eq 119
      expect(send_many_hash["addr5"]).to eq 19
    end

  end
end
