module Bitsy
  module Updating
    class UpdateTransactions

      include LightService::Action
      expects :payment_transactions, :latest_block

      executed do |ctx|
        ctx.payment_transactions.each do |tx|
          UpdateTransaction.execute(
            payment_transaction: tx,
            latest_block: ctx.latest_block,
          )
        end
      end

    end
  end
end
