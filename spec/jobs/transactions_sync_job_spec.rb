require "spec_helper"

module Bitsy
  describe TransactionsSyncJob, "#perform" do

    it "executes UpdateTransactions" do
      expect(Updating::SyncTransactions).to receive(:execute)
      described_class.new.perform
    end

  end
end
