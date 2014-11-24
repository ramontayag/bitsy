module Bitsy
  class BuildSendManyHashForTransaction

    include LightService::Action
    expects :payment_transaction, :amount_for_splitting, :total_amount
    promises :transaction_send_many_hash

    executed do |ctx|
      tax_amount = tax_amount_from(ctx)
      owner_amount = owner_amount_from(ctx)

      payment_depot = ctx.payment_transaction.payment_depot

      ctx.transaction_send_many_hash = {
        payment_depot.tax_address => tax_amount,
        payment_depot.owner_address => owner_amount,
      }
    end

    private

    def self.tax_amount_from(ctx)
      fee_less_share_for_transaction_fee(
        ctx.payment_transaction.forward_tax_fee,
        ctx.amount_for_splitting,
        ctx.total_amount,
      )
    end

    def self.owner_amount_from(ctx)
      fee_less_share_for_transaction_fee(
        ctx.payment_transaction.owner_fee,
        ctx.amount_for_splitting,
        ctx.total_amount,
      )
    end

    def self.fee_less_share_for_transaction_fee(fee, amount_for_splitting, total_amount)
      percent_of_total = fee / total_amount
      (percent_of_total * 100_000_000 * amount_for_splitting).to_i
    end

  end
end
