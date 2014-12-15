module Bitsy
  class CheckForPayments

    include LightService::Organizer

    def self.execute
      reduce(
        FetchPaymentDepotsForManualChecking,
        GetLatestBlockIfPaymentDepots,
        CheckPaymentDepotsTransactions,
      )
    end

  end
end
