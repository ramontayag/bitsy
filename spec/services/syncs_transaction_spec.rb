require "spec_helper"

describe SyncsTransaction, ".execute" do

  let(:bit_wallet_tx) do
    double
  end

  context "bit wallet transaction has not been synced before" do
    before do
      allow(PaymentTransaction).to receive(:matching_bit_wallet_transaction).
        with(bit_wallet_tx).and_return([])
    end

    it "creates the payment transaction" do
      expect(CreatesTransaction).to receive(:execute).
        with(bit_wallet_tx)

      described_class.execute(bit_wallet_tx)
    end
  end

  context "bit wallet transaction has been synced before" do
    let(:payment_tx) { build_stubbed(:payment_transaction) }

    before do
      allow(PaymentTransaction).to receive(:matching_bit_wallet_transaction).
        with(bit_wallet_tx).and_return([payment_tx])
    end

    it "updates the payment transaction" do
      expect(UpdatesTransaction).to receive(:execute).
        with(bit_wallet_tx, payment_tx)

      described_class.execute(bit_wallet_tx)
    end
  end

end
