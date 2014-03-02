require "spec_helper"

describe ProcessesPayments, ".for", integration: true do

  let(:wallet) { App.bit_wallet }
  let(:bit_wallet_master_account) { build(:bit_wallet_account) }

  it "processes the payments for a bit_wallet" do
    actions = [
      SelectsTransactionsForSync,
      SyncsTransactions,
      ForwardsPayments
    ]

    ctx = { bit_wallet: wallet,
            bit_wallet_master_account: bit_wallet_master_account }

    actions.each do |action|
      expect(action).to receive(:execute).with(ctx) { ctx }
    end

    described_class.for(wallet, bit_wallet_master_account)
  end

end
