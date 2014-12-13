module Bitsy
  class ProcessBlockchainBlockexplorerTransaction

    include LightService::Action
    expects :payment_depot, :latest_block, :blockchain_transaction

    executed do |ctx|
      tx = ctx.blockchain_transaction
      next ctx if PaymentTransaction.exists?(transaction_id: tx.hash)
      payment_depot = ctx.payment_depot
      output = tx.outputs.find { |o| o.address == payment_depot.address }
      PaymentTransaction.create!(
        payment_depot_id: payment_depot.id,
        amount: output.value / 100_000_000.0,
        receiving_address: output.address,
        payment_type: "receive",
        confirmations: confirmations_of(tx, ctx.latest_block.height),
        transaction_id: tx.hash,
      )
    end

    private

    def self.confirmations_of(tx, block_height)
      if tx.block_height
        block_height + 1 - tx.block_height
      else
        0
      end
    end

  end
end
