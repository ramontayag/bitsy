class TransactionsPoller

  def sync
    transactions.each do |tx|
      if !PaymentTransaction.exists?(transaction_id: tx.id)
        payment_depot = PaymentDepot.find(tx.account.name.to_i)
        PaymentTransaction.create(payment_depot: payment_depot,
                                  amount: tx.amount,
                                  confirmations: tx.confirmations,
                                  transaction_id: tx.id,
                                  receiving_address: tx.address_str,
                                  category: tx.category,
                                  occurred_at: tx.occurred_at,
                                  recieved_at: tx.recieved_at)
      end
    end
  end

  private

  def transactions
    App.bit_wallet.recent_transactions
  end

end
