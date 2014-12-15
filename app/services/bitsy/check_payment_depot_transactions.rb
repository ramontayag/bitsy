module Bitsy
  class CheckPaymentDepotTransactions

    include LightService::Action
    expects :latest_block, :payment_depot

    executed do |ctx|
      blockchain_address = Blockchain.get_address(ctx.payment_depot.address)
      blockchain_address.transactions.each do |tx|
        ProcessBlockchainBlockexplorerTransaction.execute(
          payment_depot: ctx.payment_depot,
          latest_block: ctx.latest_block,
          blockchain_transaction: tx,
        )
      end
      ctx.payment_depot.reset_checked_at!
    end

  end
end
