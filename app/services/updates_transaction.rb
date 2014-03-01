class UpdatesTransaction

  def self.execute(bit_wallet_tx, payment_tx)
    payment_tx.update_attributes(confirmations: bit_wallet_tx.confirmations)
  end

end
