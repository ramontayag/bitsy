class ProcessesPayments

  include LightService::Organizer

  def self.for(args={})
    bit_wallet = args.fetch(:bit_wallet)
    bit_wallet_master_account = args.fetch(:bit_wallet_master_account)
    tax_address = args.fetch(:tax_address)

    ctx = { bit_wallet: bit_wallet,
            bit_wallet_master_account: bit_wallet_master_account,
            tax_address: tax_address }
    with(ctx).reduce([
      SelectsTransactionsForSync,
      SyncsTransactions,
      ForwardsPayments
    ])
  end

end
