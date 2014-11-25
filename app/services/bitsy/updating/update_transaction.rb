module Bitsy
  module Updating
    class UpdateTransaction

      include LightService::Action
      expects :latest_block, :payment_transaction

      executed do |ctx|
        blockchain_tx = Blockchain.
          get_tx(ctx.payment_transaction.transaction_id)
        confirmations = if blockchain_tx.block_height
                          ctx.latest_block.height -
                            blockchain_tx.block_height + 1
                        else
                          0
                        end
        ctx.payment_transaction.update_attributes(
          confirmations: confirmations
        )
      end

    end
  end
end
