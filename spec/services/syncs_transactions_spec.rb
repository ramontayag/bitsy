require "spec_helper"

describe SyncsTransactions, ".execute" do

  it "syncs all recent bit wallet transactions" do
    bit_wallet_tx_1 = build(:bit_wallet_transaction)
    bit_wallet_tx_2 = build(:bit_wallet_transaction)
    bit_wallet_txs = [bit_wallet_tx_1, bit_wallet_tx_2]

    bit_wallet = build(:bit_wallet)
    allow(bit_wallet).to receive(:recent_transactions) { bit_wallet_txs }
    allow(App).to receive(:bit_wallet) { bit_wallet }

    bit_wallet_txs.each do |bw_tx|
      expect(SyncsTransaction).to receive(:for).with(bw_tx).once
    end

    described_class.execute({})
  end

end
