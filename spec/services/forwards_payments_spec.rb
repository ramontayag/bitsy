require "spec_helper"

# ForwardsPayments attemps to save on Bitcoin transaction fees. Since
# application is meant to accept micro payments, sending a fee (0.0001) every
# time we receive a payment would be costly.
#
# If all the transactions meant to forwarded are on or past the threshold for
# forwarding, the master account will create one transaction that sends it to
# the tax address, and the owner addresses. This allows the system to spend only
# one fee everytime we reach the threshold.

describe ForwardsPayments, ".execute" do
  let(:bit_wallet_master_account) { build(:bit_wallet_account) }
  let(:actions) do
    [
      BuildsSendManyHash,
      SendsPayments,
      AssociatesTransactions
    ]
  end

  let(:tax_address) { "taxaddr" }

  let(:payment_txs) do
    [
      build_stubbed(:payment_transaction),
      build_stubbed(:payment_transaction)
    ]
  end

  let(:ctx) do
    {
      payment_transactions: payment_txs,
      bit_wallet_master_account: bit_wallet_master_account,
      tax_address: tax_address
    }
  end

  before do
    allow(PaymentTransaction).to receive(:for_forwarding) { payment_txs }
  end

  context "transactions on or past the threshold" do
    before do
      allow(payment_txs).to receive(:sum).with(:amount).
        and_return(App.forward_threshold)
    end

    it "performs the actions in order" do
      actions.each do |action|
        expect(action).to receive(:execute).with(ctx) { ctx }
      end

      described_class.
        execute(bit_wallet_master_account: bit_wallet_master_account,
                tax_address: tax_address)
    end
  end

  context "transactions are not past the threshold" do
    before do
      allow(payment_txs).to receive(:sum).with(:amount).
        and_return(App.forward_threshold - 0.1)
    end

    it "does nothing" do
      actions.each do |action|
        expect(action).to_not receive(:execute)
      end

      described_class.
        execute(bit_wallet_master_account: bit_wallet_master_account)
    end
  end
end
