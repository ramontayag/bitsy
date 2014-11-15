# This migration comes from bitsy (originally 20141115001846)
class AddTotalReceivedAmountCacheToPaymentDepots < ActiveRecord::Migration
  def change
    add_column :bitsy_payment_depots, :total_received_amount_cache, :float, null: false, default: 0
  end
end
