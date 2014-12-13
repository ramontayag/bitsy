require "spec_helper"

module Bitsy
  describe BlockchainNotification do

    describe "validations" do
      it do
        should ensure_inclusion_of(:secret).
          in_array(Bitsy.config.blockchain_secrets)
      end
    end

    describe "#test" do
      it "is an accessor for testing purposes" do
        notification = described_class.new(test: "true")
        expect(notification.test).to be true

        notification = described_class.new(test: "false")
        expect(notification.test).to be false
      end
    end

  end
end
