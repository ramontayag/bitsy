module Bitsy
  class TransactionsUpdateJob

    include Sidekiq::Worker

    def perform
      UpdateTransactions.execute
    end

  end
end
