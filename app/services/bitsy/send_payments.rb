module Bitsy
  class SendPayments

    include LightService::Action
    expects :send_many_hash, :wallet, :computed_transaction_fee
    promises :forwarding_transaction_id

    executed do |ctx|
      if Bitsy.config.debug
        ctx.forwarding_transaction_id = nil
        next ctx
      end

      payment_response = ctx.wallet.send_many(
        ctx.send_many_hash,
        fee: ctx.computed_transaction_fee,
      )
      ctx.forwarding_transaction_id = payment_response.tx_hash
    end

  end
end
