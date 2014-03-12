require "spec_helper"

describe StockpilesTransaction, ".execute" do

  let(:bit_wallet) { build(:bit_wallet) }

  context "bit wallet transaction category == 'receive'" do
    let(:bit_wallet_account) { build(:bit_wallet_account, wallet: bit_wallet) }
    let(:bit_wallet_tx) do
      build(:bit_wallet_transaction, account: bit_wallet_account)
    end
    let(:payment_depot) { build_stubbed(:payment_depot) }
    let(:payment_tx) do
      build(:payment_transaction,
            payment_depot: payment_depot,
            payment_type: "receive")
    end
    let(:bit_wallet_master_account) do
      build(:bit_wallet_account, name: "stockpiler", wallet: bit_wallet)
    end

    it "moves the funds to the master account" do
      expect(bit_wallet).to receive(:move).with(
        payment_depot.bitcoin_account_name,
        "stockpiler",
        payment_tx.amount.to_f
      )

      described_class.execute(
        payment_transaction: payment_tx,
        bit_wallet_transaction: bit_wallet_tx,
        bit_wallet_master_account: bit_wallet_master_account
      )
    end
  end

  context "bit wallet transaction cateogry is not 'receive'" do
    let(:payment_tx) do
      build_stubbed(:payment_transaction, payment_type: "send")
    end

    it "does nothing" do
      expect(bit_wallet).to_not receive(:move)
      described_class.execute(payment_transaction: payment_tx)
    end
  end

  context "there is no payment transaction" do
    let(:payment_tx) { nil }

    it "does nothing" do
      expect(bit_wallet).to_not receive(:move)
      described_class.execute(payment_transaction: payment_tx)
    end
  end

end
