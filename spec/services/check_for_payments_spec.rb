require "spec_helper"

module Bitsy
  describe CheckForPayments, ".execute" do

    it "executes actions" do
      actions = [
        GetLatestBlock,
        CheckPaymentDepotTransactions,
      ]

      ctx = {}

      actions.each do |action|
        expect(action).to receive(:execute).with(ctx).and_return(ctx)
      end

      described_class.execute
    end

  end
end
