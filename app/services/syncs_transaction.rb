module Bitsy
  class SyncsTransaction

    include LightService::Organizer

    def self.for(args={})
      bit_wallet_tx = args.fetch(:bit_wallet_transaction)

      payment_tx = PaymentTransaction.
        matching_bit_wallet_transaction(bit_wallet_tx).first
      ctx = { payment_transaction: payment_tx,
              bit_wallet_transaction: bit_wallet_tx }

      actions = []
      if payment_tx
        actions << UpdatesTransaction
      else
        ctx[:bit_wallet_master_account] = args.fetch(:bit_wallet_master_account)
        actions += [CreatesTransaction, StockpilesTransaction]
      end

      with(ctx).reduce(actions)
    end

  end
end
