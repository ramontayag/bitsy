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

    context "non-debug mode" do
      before { Bitsy.config.debug = false }

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

    context "debug mode" do
      before { Bitsy.config.debug = true }

      it "does not initiate any payment" do
        ctx = {
          wallet: wallet,
          send_many_hash: send_many_hash,
          computed_transaction_fee: transaction_fee,
        }
        expect(wallet).to_not receive(:send_many)
        described_class.execute(ctx)
      end
    end

  end
end
