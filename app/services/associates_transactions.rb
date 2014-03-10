class AssociatesTransactions

  include LightService::Action

  executed do |ctx|
    payment_txs = ctx.fetch(:payment_transactions)
    forwarding_transaction_id = ctx.fetch(:forwarding_transaction_id)
    payment_txs.update_all(forwarding_transaction_id: forwarding_transaction_id)
  end

end
