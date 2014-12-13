module Bitsy
  class CheckPaymentDepotTransaction

    include LightService::Action
    expects :latest_block, :payment_depot

    executed do |ctx|
      blockchain_address = Blockchain.get_address(ctx.payment_depot.address)
      blockchain_address.txs.each do |tx|
        ProcessBlockchainBlockexplorerTransaction.execute(
          payment_depot: ctx.payment_depot,
          latest_block: ctx.latest_block,
          blockchain_transaction: tx,
        )
      end
    end

  end
end
