module Bitsy
  class SelectsTransactionsForSync

    include LightService::Action

    executed do |ctx|
      bit_wallet = ctx.fetch(:bit_wallet)
      txs = bit_wallet.recent_transactions.select {|tx| tx.category == "receive"}
      ctx[:bit_wallet_transactions] = txs
    end

  end
end
