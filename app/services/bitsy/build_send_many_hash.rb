module Bitsy
  class BuildSendManyHash

    include LightService::Action
    expects :payment_transactions, :amount_for_splitting, :total_amount
    promises :send_many_hash, :computed_transaction_fee

    executed do |ctx|
      ctx.send_many_hash = send_many_hash_from(ctx)
      total_payments = total_payments_from(ctx.send_many_hash)
      ctx.computed_transaction_fee =
        (ctx.total_amount * 100_000_000.0 - total_payments).round
    end

    private

    def self.send_many_hash_from(ctx)
      send_many_hash = {}

      ctx.payment_transactions.each do |tx|
        tx_hash = BuildSendManyHashForTransaction.execute(
          payment_transaction: tx,
          amount_for_splitting: ctx.amount_for_splitting,
          total_amount: ctx.total_amount,
        ).transaction_send_many_hash

        tx_hash.each do |address, amount|
          if send_many_hash.has_key?(address)
            send_many_hash[address] += amount
          else
            send_many_hash[address] = amount
          end
        end
      end

      send_many_hash
    end

    def self.total_payments_from(send_many_hash)
      send_many_hash.inject(0) do |sum, hash|
        sum += hash[1]
        sum
      end
    end

  end
end
