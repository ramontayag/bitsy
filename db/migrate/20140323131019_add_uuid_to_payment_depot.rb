class AddUuidToPaymentDepot < ActiveRecord::Migration
  def change
    add_column :payment_depots, :uuid, :string
    add_index :payment_depots, :uuid
  end
end
