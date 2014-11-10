module Bitsy
  class ProcessBlockchainNotification

    include LightService::Action
    expects :blockchain_notification
    promises :payment_transaction

    executed do |ctx|
      bn = ctx.blockchain_notification
      payment_depot = PaymentDepot.find_by(address: bn.input_address)
      ctx.payment_transaction = PaymentTransaction.create!(
        payment_depot_id: payment_depot.id,
        amount: bn.value / 100_000_000.0,
        receiving_address: bn.input_address,
        payment_type: "receive",
        confirmations: bn.confirmations,
        transaction_id: bn.transaction_hash,
      )
    end

  end
end
