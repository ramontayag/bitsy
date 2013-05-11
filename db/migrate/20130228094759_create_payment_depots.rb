class CreatePaymentDepots < ActiveRecord::Migration
  def change
    create_table :payment_depots do |t|
      t.decimal :min_payment, null: false
      t.decimal :initial_tax_rate, null: false
      t.decimal :added_tax_rate, null: false
      t.decimal :balance_cache, null: false, default: 0.0
      t.string :owner_address
      t.string :address, null: false
      t.timestamps
    end
  end
end
