require "spec_helper"

module Bitsy
  describe BlockchainNotification do

    describe "validations" do
      it do
        should ensure_inclusion_of(:secret).
          in_array(Bitsy.config.blockchain_secrets)
      end
    end

  end
end
