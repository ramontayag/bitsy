module Bitsy
  module V1
    class BlockchainNotificationsController < ApplicationController

      def index
        BlockchainNotification.create(blockchain_notification_params)
        render nothing: true, status: 200
      end

      protected

      def blockchain_notification_params
        params.permit(
          :value,
          :transaction_hash,
          :input_address,
          :confirmations,
          :secret,
        )
      end

    end
  end
end
