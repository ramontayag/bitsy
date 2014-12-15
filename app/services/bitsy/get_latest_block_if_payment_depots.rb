module Bitsy
  class GetLatestBlockIfPaymentDepots

    include LightService::Action
    expects :payment_depots
    promises :latest_block

    executed do |ctx|
      ctx.latest_block = if ctx.payment_depots.any?
                           Blockchain.get_latest_block
                         end
    end

  end
end
