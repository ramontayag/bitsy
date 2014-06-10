require "spec_helper"

module Bitsy
  describe SelectsTransactionsForSync, ".execute" do

    it "sets the recent received transactions on :bit_wallet_transactions" do
      tx_1 = build(:bit_wallet_transaction, category: "receive")
      tx_2 = build(:bit_wallet_transaction, category: "send")
      tx_3 = build(:bit_wallet_transaction, category: "receive")
      recent_transactions = [tx_1, tx_2, tx_3]
      bit_wallet = build(:bit_wallet)
      allow(bit_wallet).to receive(:recent_transactions) { recent_transactions }

      ctx = { bit_wallet: bit_wallet }
      resulting_ctx = described_class.execute(ctx)

      expect(resulting_ctx[:bit_wallet_transactions]).to eq([tx_1, tx_3])
    end

  end
end
