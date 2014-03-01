require "spec_helper"

describe BuildsSendManyHash do

  describe ".execute" do
    it "returns a hash representing all payment transactions to be made" do
      payment_tx_1 = build_stubbed(:payment_transaction)
      payment_tx_2 = build_stubbed(:payment_transaction)
      payment_tx_3 = build_stubbed(:payment_transaction)
      payment_txs = [ payment_tx_1, payment_tx_2, payment_tx_3 ]

      allow(described_class).to receive(:for_transaction).with(payment_tx_1).
        and_return({addr_1: 1})
      allow(described_class).to receive(:for_transaction).with(payment_tx_2).
        and_return({addr_2: 2, addr_4: 0.1})
      allow(described_class).to receive(:for_transaction).with(payment_tx_3).
        and_return({addr_1: 0.2, addr_2: 1.5})

      ctx = { payment_transactions: payment_txs }

      resulting_ctx = described_class.execute(ctx)

      expect(resulting_ctx[:send_many_hash]).
        to eq(addr_1: 1.2, addr_2: 3.5, addr_4: 0.1)
    end
  end

  describe ".for_transaction" do
    it "returns a send_many hash for the single transaction" do
      payment_depot = build_stubbed(:payment_depot,
                                    address: "payment_depot_address")
      payment_tx = build_stubbed(:payment_transaction,
                                 payment_depot: payment_depot)
      expect(payment_tx).to receive(:forward_tax_fee) { 0.15 }
      expect(payment_tx).to receive(:owner_fee) { 0.85 }

      expected_hash = { App.tax_address => 0.15,
                        "payment_depot_address" => 0.85 }

      expect(described_class.for_transaction(payment_tx)).to eq(expected_hash)
    end
  end


end
