module Bitsy
  module V1
    class BlockchainNotificationsController < ApplicationController

      def index
        bn = BlockchainNotification.new(blockchain_notification_params)
        if bn.test
          render text: "*ok*", status: 200
        elsif bn.save
          BlockchainNotificationJob.perform_async(bn.id)
          render text: "*ok*", status: 200
        else
          render nothing: true, status: 422
        end
      end

      protected

      def blockchain_notification_params
        params.permit(
          :value,
          :transaction_hash,
          :input_address,
          :confirmations,
          :secret,
          :test,
        )
      end

    end
  end
end
