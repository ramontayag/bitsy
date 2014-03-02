require "spec_helper"

describe CreatesTransaction, ".execute" do

  context "transaction is one that's being watched (by payment depot)" do
    it "creates a payment transaction from the bit wallet transaction" do
      bit_wallet_tx = build(:bit_wallet_transaction,
                            id: 'txid',
                            address_str: 'rumplestiltskin',
                            amount: 2.13,
                            confirmations: 2,
                            category: "received",
                            occurred_at: Time.at(1365328873),
                            received_at: Time.at(1365328875))

      payment_tx = build_stubbed(:payment_transaction)
      payment_depot = build_stubbed(:payment_depot)

      allow(PaymentDepot).to receive(:find_by_address).
        with("rumplestiltskin").and_return(payment_depot)

      expect(PaymentTransaction).to receive(:create).with(
        payment_depot_id: payment_depot.id,
        amount: 2.13,
        receiving_address: "rumplestiltskin",
        transaction_id: "txid",
        confirmations: 2,
        payment_type: "received",
        occurred_at: Time.at(1365328873),
        received_at: Time.at(1365328875)
      ).and_return(payment_tx)

      resulting_ctx = described_class.
        execute(bit_wallet_transaction: bit_wallet_tx)

      expect(resulting_ctx[:payment_transaction]).to eq(payment_tx)
    end
  end

  context "transaction is one that's not being watched" do
    it "creates a payment transaction from the bit wallet transaction" do
      bit_wallet_tx = build(:bit_wallet_transaction,
                            id: 'txid',
                            address_str: 'rumplestiltskin',
                            amount: 2.13,
                            confirmations: 2,
                            category: "received",
                            occurred_at: Time.at(1365328873),
                            received_at: Time.at(1365328875))

      payment_tx = build_stubbed(:payment_transaction)
      payment_depot = build_stubbed(:payment_depot)

      allow(PaymentDepot).to receive(:find_by_address).
        with("rumplestiltskin").and_return(nil)

      expect(PaymentTransaction).to_not receive(:create)

      resulting_ctx = described_class.
        execute(bit_wallet_transaction: bit_wallet_tx)

      expect(resulting_ctx[:payment_transaction]).to be_nil
    end
  end

end
