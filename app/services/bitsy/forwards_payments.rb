module Bitsy
  class ForwardsPayments

    include LightService::Organizer
    include LightService::Action

    executed do |ctx|
      payment_transactions = PaymentTransaction.for_forwarding

      if past_threshold?(payment_transactions)
        bit_wallet_master_account = ctx.fetch(:bit_wallet_master_account)
        context = {
          bit_wallet_master_account: bit_wallet_master_account,
          payment_transactions: payment_transactions
        }
        with(context).reduce([
          BuildsSendManyHash,
          SendsPayments,
          AssociatesTransactions
        ])
      end
    end

    private

    def self.past_threshold?(payment_txs)
      payment_txs.sum(:amount) >= Bitsy.config.forward_threshold
    end

  end
end
