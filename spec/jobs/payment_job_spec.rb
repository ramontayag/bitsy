require "spec_helper"

module Bitsy
  describe PaymentJob, "#perform" do

    it "calls ProcessesPayments to do the work" do
      bit_wallet = build(:bit_wallet)
      allow(Bitsy).to receive(:bit_wallet) { bit_wallet}

      bit_wallet_master_account = build(:bit_wallet_account)
      allow(Bitsy).to receive(:master_account) { bit_wallet_master_account }

      expect(ProcessesPayments).to receive(:for).with(
        bit_wallet: Bitsy.bit_wallet,
        bit_wallet_master_account: Bitsy.master_account,
      )
      described_class.new.perform
    end

  end
end
