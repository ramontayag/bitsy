class StockpilesTransaction

  include LightService::Action

  executed do |ctx|
    payment_tx = ctx.fetch(:payment_transaction)
    if payment_tx.payment_type == "receive"
      bit_wallet_tx = ctx.fetch(:bit_wallet_transaction)
      bit_wallet = bit_wallet_tx.account.wallet
      payment_depot = payment_tx.payment_depot

      bit_wallet.move(
        payment_depot.bitcoin_account_name,
        App.bitcoin_master_account_name,
        payment_tx.amount
      )
    end
  end

end
