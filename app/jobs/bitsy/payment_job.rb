module Bitsy
  class PaymentJob

    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform
      ProcessesPayments.for(
        bit_wallet: Bitsy.bit_wallet,
        bit_wallet_master_account: Bitsy.master_account
      )
    end

  end
end
