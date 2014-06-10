module Bitsy
  class SendsPayments

    include LightService::Action

    executed do |ctx|
      bit_wallet_master_account = ctx.fetch(:bit_wallet_master_account)
      send_many_hash = ctx.fetch(:send_many_hash)
      tx_id = bit_wallet_master_account.send_many(send_many_hash)
      ctx[:forwarding_transaction_id] = tx_id
    end

  end
end
