module Bitsy
  module Updating
    class SelectTransactions

      include LightService::Action
      promises :payment_transactions

      executed do |ctx|
        txs = PaymentTransaction.not_forwarded
        txs.each do |tx|
          UpdateTransaction.execute(payment_transaction: tx)
        end
        ctx.payment_transactions = txs
      end

    end
  end
end
