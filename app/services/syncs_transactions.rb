class SyncsTransactions

  include LightService::Action

  executed do |ctx|
    App.bit_wallet.recent_transactions.each do |bit_wallet_tx|
      SyncsTransaction.execute(bit_wallet_tx)
    end
  end

end
