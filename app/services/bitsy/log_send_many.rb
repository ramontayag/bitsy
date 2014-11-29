module Bitsy
  class LogSendMany

    include LightService::Action
    expects :payment_transactions, :computed_transaction_fee, :send_many_hash

    executed do |ctx|
      message = ["Will forward transactions for payment transactions:"]
      message << ctx.payment_transactions.map(&:id).join(", ")
      message << "hash: #{ctx.send_many_hash.inspect}"
      message << "Transaction fee: #{ctx.computed_transaction_fee.to_f}"
      message = message.join("\n")

      logger = Logger.new(Bitsy.config.send_many_log_path)
      logger.info(message)
    end

  end
end
