class ProcessesPayments

  include LightService::Organizer

  def self.for(bit_wallet, bit_wallet_master_account)
    ctx = { bit_wallet: bit_wallet,
            bit_wallet_master_account: bit_wallet_master_account }
    with(ctx).reduce([
      SyncsTransactions,
      ForwardsPayments
    ])
  end

end
