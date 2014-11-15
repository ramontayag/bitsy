class AddTotalReceivedAmountCacheToPaymentDepots < ActiveRecord::Migration
  def change
    add_column :bitsy_payment_depots, :total_received_amount_cache, :float, null: false, default: 0
  end
end
