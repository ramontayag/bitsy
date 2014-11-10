module Bitsy
  class ForwardPayments

    include LightService::Organizer
    include LightService::Action

    def self.execute
      payment_transactions = PaymentTransaction.for_forwarding

      return unless past_threshold?(payment_transactions)
      with(
        payment_transactions: payment_transactions
      ).reduce([
        InstantiateBlockchainWallet,
        BuildSendManyHash,
        SendPayments,
        AssociatesTransactions
      ])
    end

    private

    def self.past_threshold?(payment_txs)
      payment_txs.sum(:amount) >= Bitsy.config.forward_threshold_amount
    end

  end
end
