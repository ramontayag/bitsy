require "spec_helper"

module Bitsy
  describe BuildSendManyHashWithTransactionFee, ".execute" do

    it "executes actions in order" do
      actions = [
        ComputeAmountForSplitting,
        BuildSendManyHash,
      ]

      ctx = { payment_transactions: double, transaction_fee: 0.2 }

      actions.each do |action|
        expect(action).to receive(:execute).with(ctx).and_return(ctx)
      end

      described_class.execute(ctx)
    end

  end
end
