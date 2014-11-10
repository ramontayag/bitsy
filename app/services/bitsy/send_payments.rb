module Bitsy
  class SendPayments

    include LightService::Action
    expects :send_many_hash, :wallet
    promises :forwarding_transaction_id

    executed do |ctx|
      payment_response = ctx.wallet.send_many(ctx.send_many_hash)
      ctx.forwarding_transaction_id = payment_response.tx_hash
    end

  end
end
