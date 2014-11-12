require "spec_helper"

module Bitsy
  describe ForwardJob, "#perform" do

    it "does not retry" do
      expect(described_class.sidekiq_options_hash['retry']).to be false
    end

    it "executes ForwardsPayments" do
      expect(ForwardPayments).to receive(:execute).once
      described_class.new.perform
    end

  end
end
