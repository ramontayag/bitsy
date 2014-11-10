module Bitsy
  class AssociatesTransactions

    include LightService::Action
    expects :forwarding_transaction_id, :payment_transactions

    executed do |ctx|
      ctx.payment_transactions.
        update_all(forwarding_transaction_id: ctx.forwarding_transaction_id)
    end

  end
end
