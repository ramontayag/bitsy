module Bitsy
  class ComputeAmountForSplitting

    include LightService::Action
    expects :payment_transactions, :transaction_fee
    promises :amount_for_splitting, :total_amount

    executed do |ctx|
      ctx.total_amount = ctx.payment_transactions.sum(:amount)
      ctx.amount_for_splitting = ctx.total_amount - ctx.transaction_fee
    end

  end
end
