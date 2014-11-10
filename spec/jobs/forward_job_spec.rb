require "spec_helper"

module Bitsy
  describe ForwardJob, "#perform" do

    it "executes ForwardsPayments" do
      expect(ForwardPayments).to receive(:execute).once
      described_class.new.perform
    end

  end
end
