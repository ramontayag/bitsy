class AddTaxAddressToPaymentDepot < ActiveRecord::Migration
  def change
    add_column :payment_depots, :tax_address, :string
  end
end
