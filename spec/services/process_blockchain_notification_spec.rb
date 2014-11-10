require "spec_helper"

module Bitsy
  describe ProcessBlockchainNotification, ".execute" do

    let(:blockchain_notification) do
      build_stubbed(:blockchain_notification, {
        transaction_hash: "transaction_hash",
        input_address: "address",
        value: 3_300_000,
        confirmations: 1,
      })
    end
    let(:payment_depot) { build_stubbed(:payment_depot, address: "address") }
    let(:payment_transaction) { build_stubbed(:payment_transaction) }

    before do
      allow(PaymentDepot).to receive(:find_by).with(address: "address").
        and_return(payment_depot)
    end

    it "creates a corresponding payment transaction" do
      expect(PaymentTransaction).to receive(:create!).with(
        payment_depot_id: payment_depot.id,
        amount: 0.033,
        receiving_address: "address",
        payment_type: "receive",
        confirmations: 1,
        transaction_id: "transaction_hash",
      ).and_return(payment_transaction)

      resulting_ctx = described_class.
        execute(blockchain_notification: blockchain_notification)

      expect(resulting_ctx.payment_transaction).to eq payment_transaction
    end

  end
end
