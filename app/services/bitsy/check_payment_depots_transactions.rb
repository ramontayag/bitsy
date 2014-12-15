module Bitsy
  class CheckPaymentDepotsTransactions

    include LightService::Action
    expects :latest_block, :payment_depots

    executed do |ctx|
      ctx.payment_depots.find_each do |payment_depot|
        CheckPaymentDepotTransactions.execute(
          payment_depot: payment_depot,
          latest_block: ctx.latest_block,
        )
      end
    end

  end
end
