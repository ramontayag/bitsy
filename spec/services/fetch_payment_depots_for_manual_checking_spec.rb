require "spec_helper"

module Bitsy
  describe FetchPaymentDepotsForManualChecking, ".execute" do

    it "sets the payment depots for manual checking in the context" do
      payment_depots = double
      expect(PaymentDepot).to receive(:for_manual_checking).
        and_return(payment_depots)
      resulting_ctx = described_class.execute
      expect(resulting_ctx.payment_depots).to eq payment_depots
    end

  end
end
