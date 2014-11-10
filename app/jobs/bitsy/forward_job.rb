module Bitsy
  class ForwardJob

    include Sidekiq::Worker

    def perform
      ForwardPayments.execute
    end

  end
end
