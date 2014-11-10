# This migration comes from bitsy (originally 20141109072242)
class ChangePaymentDepotBalanceCacheDefault < ActiveRecord::Migration
  def change
    change_column :bitsy_payment_depots, :balance_cache, :decimal, null: false, default: 0
  end
end
