class CreatesTransaction

  include LightService::Action

  executed do |ctx|
    bit_wallet_tx = ctx.fetch(:bit_wallet_transaction)
    payment_depot = PaymentDepot.find_by_address(bit_wallet_tx.address_str)
    payment_tx = PaymentTransaction.create(
      payment_depot_id: payment_depot.id,
      amount: bit_wallet_tx.amount,
      receiving_address: bit_wallet_tx.address_str,
      transaction_id: bit_wallet_tx.id,
      confirmations: bit_wallet_tx.confirmations,
      payment_type: bit_wallet_tx.category,
      occurred_at: bit_wallet_tx.occurred_at,
      received_at: bit_wallet_tx.received_at
    )
    ctx[:payment_transaction] = payment_tx
  end

end
