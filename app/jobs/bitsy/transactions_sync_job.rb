module Bitsy
  class TransactionsSyncJob

    include Sidekiq::Worker

    def perform
      Updating::SyncTransactions.execute
    end

  end
end
