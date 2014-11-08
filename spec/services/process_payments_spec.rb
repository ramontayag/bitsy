require "spec_helper"

module Bitsy
  describe ProcessPayments, ".for", integration: true do

    let(:wallet) { Bitsy.bit_wallet }
    let(:bit_wallet_master_account) { build(:bit_wallet_account) }

    it "process the payments for a bit_wallet" do
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

      described_class.for(bit_wallet: wallet,
                          bit_wallet_master_account: bit_wallet_master_account)
    end

  end
end
