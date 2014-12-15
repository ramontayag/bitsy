module Bitsy
  class FetchPaymentDepotsForManualChecking

    include LightService::Action
    promises :payment_depots

    executed do |ctx|
      ctx.payment_depots = PaymentDepot.for_manual_checking
    end

  end
end
