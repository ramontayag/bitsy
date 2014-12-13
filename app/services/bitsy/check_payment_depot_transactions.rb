module Bitsy
  class CheckPaymentDepotTransactions

    include LightService::Action
    expects :latest_block, :payment_depots

    executed do |ctx|
      ctx.payment_depots.each do |payment_depot|
        CheckPaymentDepotTransaction.execute(
          payment_depot: payment_depot,
          latest_block: ctx.latest_block,
        )
      end
    end

  end
end
