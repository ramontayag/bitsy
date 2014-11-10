class ChangePaymentDepotBalanceCacheDefault < ActiveRecord::Migration
  def change
    change_column :bitsy_payment_depots, :balance_cache, :decimal, null: false, default: 0
  end
end
