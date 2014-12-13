module Bitsy
  class CheckForPayments

    include LightService::Organizer

    def self.execute
      reduce(
        GetLatestBlock,
        CheckPaymentDepotTransactions,
      )
    end

  end
end
