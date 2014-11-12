module Bitsy
  class BlockchainNotificationJob

    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(blockchain_notification_id)
      blockchain_notification = BlockchainNotification.
        find(blockchain_notification_id)
      ProcessBlockchainNotification.
        execute(blockchain_notification: blockchain_notification)
    end

  end
end
