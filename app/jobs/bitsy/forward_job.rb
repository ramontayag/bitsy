module Bitsy
  class ForwardJob

    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform
      ForwardPayments.execute
    end

  end
end
