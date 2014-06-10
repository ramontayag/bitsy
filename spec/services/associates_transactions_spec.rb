require "spec_helper"

module Bitsy
  describe AssociatesTransactions, ".execute" do

    it "associates the payment transactions with the bitcoin transaction that forwarded its money" do
      payment_txs = double

      expect(payment_txs).to receive(:update_all).
        with(forwarding_transaction_id: "forwarding_txid")

      ctx = { payment_transactions: payment_txs,
              forwarding_transaction_id: "forwarding_txid" }

      described_class.execute(ctx)
    end

  end
end
