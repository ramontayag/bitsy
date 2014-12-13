class AddCheckCountAndCheckedAtToPaymentDepot < ActiveRecord::Migration
  def change
    add_column :bitsy_payment_depots, :check_count, :integer, null: false, default: 0
    add_column :bitsy_payment_depots, :checked_at, :datetime
  end
end
