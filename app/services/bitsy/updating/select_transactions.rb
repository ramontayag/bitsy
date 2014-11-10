module Bitsy
  module Updating
    class SelectTransactions

      include LightService::Action
      promises :payment_transactions

      executed do |ctx|
        ctx.payment_transactions = PaymentTransaction.not_forwarded
      end

    end
  end
end
