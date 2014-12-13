module Bitsy
  class CheckPaymentsJob

    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform
      CheckForPayments.execute
    end

  end
end
