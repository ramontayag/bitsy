module Bitsy
  class ForwardPayments

    include LightService::Organizer
    include LightService::Action

    executed do |ctx|
      payment_transactions = PaymentTransaction.for_forwarding

      if past_threshold?(payment_transactions)
        context = {
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
      payment_txs.sum(:amount) >= Bitsy.config.forward_threshold_amount
    end

  end
end
