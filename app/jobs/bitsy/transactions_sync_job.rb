module Bitsy
  class TransactionsSyncJob

    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform
      Updating::SyncTransactions.execute
    end

  end
end
