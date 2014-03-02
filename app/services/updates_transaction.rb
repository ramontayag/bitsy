class UpdatesTransaction

  include LightService::Action

  executed do |ctx|
    bit_wallet_tx = ctx.fetch(:bit_wallet_transaction)
    payment_tx = ctx.fetch(:payment_transaction)
    payment_tx.update_attributes(confirmations: bit_wallet_tx.confirmations)
  end

end
