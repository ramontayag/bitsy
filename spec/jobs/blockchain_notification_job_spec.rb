require "spec_helper"

module Bitsy
  describe BlockchainNotificationJob, "#perform" do

    let(:blockchain_notification) { build_stubbed(:blockchain_notification) }

    before do
      allow(BlockchainNotification).to receive(:find).
        with(blockchain_notification.id).and_return(blockchain_notification)
    end

    it "calls ProcessBlockchainNotificationJob to do the work" do
      expect(ProcessBlockchainNotification).to receive(:execute).
        with(blockchain_notification: blockchain_notification)
      described_class.new.perform(blockchain_notification.id)
    end

  end
end
