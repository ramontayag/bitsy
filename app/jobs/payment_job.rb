module Bitsy
  class PaymentJob

    include Sidekiq::Worker

    def perform
      ProcessesPayments.for(
        bit_wallet: App.bit_wallet,
        bit_wallet_master_account: App.bitcoin_master_account
      )
    end

  end
end
