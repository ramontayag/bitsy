module Bitsy
  class SyncsTransactions

    include LightService::Action

    executed do |ctx|
      bit_wallet_txs = ctx.fetch(:bit_wallet_transactions)
      bit_wallet_master_account = ctx.fetch(:bit_wallet_master_account)

      bit_wallet_txs.each do |bit_wallet_tx|
        SyncsTransaction.for(bit_wallet_transaction: bit_wallet_tx,
                             bit_wallet_master_account: bit_wallet_master_account)
      end
    end

  end
end
