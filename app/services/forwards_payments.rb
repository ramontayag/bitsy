class ForwardsPayments

  include LightService::Organizer
  include LightService::Action

  executed do |ctx|
    bit_wallet_master_account = ctx.fetch(:bit_wallet_master_account)
    payment_transactions = PaymentTransaction.for_forwarding

    if past_threshold?(payment_transactions)
      ctx = {
        bit_wallet_master_account: bit_wallet_master_account,
        payment_transactions: payment_transactions
      }
      with(ctx).reduce([
        BuildsSendManyHash,
        SendsPayments,
        AssociatesTransactions
      ])
    end
  end

  private

  def self.past_threshold?(payment_txs)
    payment_txs.sum(:amount) >= App.forward_threshold
  end

end
