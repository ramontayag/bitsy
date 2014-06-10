module Bitsy
  class ProcessesPayments

    include LightService::Organizer

    def self.for(args={})
      bit_wallet = args.fetch(:bit_wallet)
      bit_wallet_master_account = args.fetch(:bit_wallet_master_account)

      ctx = { bit_wallet: bit_wallet,
              bit_wallet_master_account: bit_wallet_master_account }
      with(ctx).reduce([
        SelectsTransactionsForSync,
        SyncsTransactions,
        ForwardsPayments
      ])
    end

  end
end
