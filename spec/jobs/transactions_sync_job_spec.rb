require "spec_helper"

module Bitsy
  describe TransactionsSyncJob, "#perform" do

    it "does not retry" do
      expect(described_class.sidekiq_options_hash['retry']).to be false
    end

    it "executes UpdateTransactions" do
      expect(Updating::SyncTransactions).to receive(:execute)
      described_class.new.perform
    end

  end
end
