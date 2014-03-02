class SendsPayments

  include LightService::Action

  executed do |ctx|
    bit_wallet_master_account = ctx.fetch(:bit_wallet_master_account)
    send_many_hash = ctx.fetch(:send_many_hash)
    bit_wallet_master_account.send_many(send_many_hash)
  end

end
