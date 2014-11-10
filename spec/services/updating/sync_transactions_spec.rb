require "spec_helper"

module Bitsy
  module Updating
    describe SyncTransactions, ".execute" do

      it "updates transactions that need it" do
        actions = [
          GetLatestBlock,
          SelectTransactions,
          UpdateTransactions,
        ]

        ctx = {}

        actions.each do |action|
          expect(action).to receive(:execute).with(ctx).and_return(ctx)
        end

        described_class.execute
      end

    end
  end
end
