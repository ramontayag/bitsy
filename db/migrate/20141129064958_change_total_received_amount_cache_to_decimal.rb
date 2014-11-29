class ChangeTotalReceivedAmountCacheToDecimal < ActiveRecord::Migration
  def up
    change_column :bitsy_payment_depots, :total_received_amount_cache, :decimal, default: 0.0, null: false
  end

  def down
    change_column :bitsy_payment_depots, :total_received_amount_cache, :float, default: 0.0, null: false
  end
end
