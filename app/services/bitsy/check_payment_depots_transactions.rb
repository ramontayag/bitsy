module Bitsy
  class CheckPaymentDepotsTransactions

    include LightService::Action
    expects :latest_block

    executed do |ctx|
      PaymentDepot.for_manual_checking.find_each do |payment_depot|
        CheckPaymentDepotTransactions.execute(
          payment_depot: payment_depot,
          latest_block: ctx.latest_block,
        )
      end
    end

  end
end
