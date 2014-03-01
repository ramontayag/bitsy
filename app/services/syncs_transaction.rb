class SyncsTransaction

  def self.execute(bit_wallet_tx)
    payment_tx = PaymentTransaction.
      matching_bit_wallet_transaction(bit_wallet_tx).first
    if payment_tx
      UpdatesTransaction.execute(bit_wallet_tx, payment_tx)
    else
      CreatesTransaction.execute(bit_wallet_tx)
    end
  end

end
