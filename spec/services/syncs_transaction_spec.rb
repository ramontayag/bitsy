require "spec_helper"

describe SyncsTransaction, ".for" do

  let(:bit_wallet_tx) do
    double
  end

  context "bit wallet transaction has not been synced before" do
    before do
      allow(PaymentTransaction).to receive(:matching_bit_wallet_transaction).
        with(bit_wallet_tx).and_return([])
    end

    it "creates the payment transaction" do
      ctx = { payment_transaction: nil, bit_wallet_transaction: bit_wallet_tx }
      actions = [CreatesTransaction, StockpilesTransaction]

      actions.each do |action|
        expect(action).to receive(:execute).with(ctx) { ctx }
      end

      described_class.for(bit_wallet_tx)
    end
  end

  context "bit wallet transaction has been synced before" do
    let(:payment_tx) { build_stubbed(:payment_transaction) }

    before do
      allow(PaymentTransaction).to receive(:matching_bit_wallet_transaction).
        with(bit_wallet_tx).and_return([payment_tx])
    end

    it "updates the payment transaction" do
      actions = [UpdatesTransaction]
      ctx = { bit_wallet_transaction: bit_wallet_tx,
              payment_transaction: payment_tx}
      actions.each do |action|
        expect(action).to receive(:execute).with(ctx) { ctx }
      end

      described_class.for(bit_wallet_tx)
    end
  end

end
