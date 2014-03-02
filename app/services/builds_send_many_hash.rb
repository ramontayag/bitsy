class BuildsSendManyHash

  include LightService::Action

  executed do |ctx|
    payment_txs = ctx.fetch(:payment_transactions)
    send_many_hash = {}

    payment_txs.each do |payment_tx|
      tx_hash = for_transaction(payment_tx)
      tx_hash.each do |address, value|
        if send_many_hash.has_key?(address)
          send_many_hash[address] = send_many_hash[address] + value
        else
          send_many_hash[address] = value
        end
      end
    end

    ctx[:send_many_hash] = send_many_hash
  end

  def self.for_transaction(payment_transaction)
    owner_address = payment_transaction.payment_depot.owner_address
    {
      App.tax_address => payment_transaction.forward_tax_fee.to_f,
      owner_address => payment_transaction.owner_fee.to_f
    }
  end

end
