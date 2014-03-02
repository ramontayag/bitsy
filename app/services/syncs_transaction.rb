class SyncsTransaction

  include LightService::Organizer

  def self.for(bit_wallet_tx)
    payment_tx = PaymentTransaction.
      matching_bit_wallet_transaction(bit_wallet_tx).first
    ctx = { payment_transaction: payment_tx,
            bit_wallet_transaction: bit_wallet_tx }

    actions = []
    if payment_tx
      actions << UpdatesTransaction
    else
      actions << CreatesTransaction
    end

    with(ctx).reduce(actions)
  end

end
