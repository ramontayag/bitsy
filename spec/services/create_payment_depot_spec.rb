require "spec_helper"

module Bitsy
  describe CreatePaymentDepot, ".execute", vcr: {record: :once} do

    let(:wallet) { InstantiateBlockchainWallet.execute.wallet }

    it "creates a payment depot with a new address and balance of that address" do
      resulting_ctx = described_class.execute(params: {
        min_payment: "0.5",
        initial_tax_rate: "0.8",
        added_tax_rate: "0.1",
        owner_address: "x9s9319",
        tax_address: "tax2388",
      })

      payment_depot = resulting_ctx.payment_depot

      expect(payment_depot.address).to_not be_nil
      expect(payment_depot.balance_cache).to be_zero
    end

  end
end
