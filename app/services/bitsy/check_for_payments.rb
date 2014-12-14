module Bitsy
  class CheckForPayments

    include LightService::Organizer

    def self.execute
      reduce(
        GetLatestBlock,
        CheckPaymentDepotsTransactions,
      )
    end

  end
end
