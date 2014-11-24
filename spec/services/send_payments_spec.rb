require "spec_helper"

module Bitsy
  describe SendPayments, ".execute" do

    let(:wallet) { build(:blockchain_wallet) }
    let(:send_many_hash) { {does: "not", matter: "ok" } }
    let(:payment_response) { build(:blockchain_payment_response, tx_hash: "h") }
    let(:transaction_fee) { 100_000 }

    before do
      allow(wallet).to receive(:send_many).with(
        send_many_hash,
        nil,
        transaction_fee,
      ).and_return(payment_response)
    end

    it "initiates a payment using the :send_many_hash" do
      ctx = {
        wallet: wallet,
        send_many_hash: send_many_hash,
        computed_transaction_fee: transaction_fee,
      }
      resulting_ctx = described_class.execute(ctx)
      expect(resulting_ctx[:forwarding_transaction_id]).to eq("h")
    end

  end
end
