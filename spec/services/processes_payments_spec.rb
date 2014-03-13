require "spec_helper"

describe ProcessesPayments, ".for", integration: true do

  let(:wallet) { App.bit_wallet }
  let(:bit_wallet_master_account) { build(:bit_wallet_account) }
  let(:tax_address) { "taxaddr" }

  it "processes the payments for a bit_wallet" do
    actions = [
      SelectsTransactionsForSync,
      SyncsTransactions,
      ForwardsPayments
    ]

    ctx = { bit_wallet: wallet,
            bit_wallet_master_account: bit_wallet_master_account,
            tax_address: "taxaddr" }

    actions.each do |action|
      expect(action).to receive(:execute).with(ctx) { ctx }
    end

    described_class.for(bit_wallet: wallet,
                        bit_wallet_master_account: bit_wallet_master_account,
                        tax_address: tax_address)
  end

end
