require "spec_helper"

module Bitsy
  describe TransactionsUpdateJob, "#perform" do

    it "executes UpdateTransactions" do
      expect(UpdateTransactions).to receive(:execute)
      described_class.new.perform
    end

  end
end
