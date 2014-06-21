# This migration comes from bitsy (originally 20140607015614)
class CreateBitsyPaymentDepots < ActiveRecord::Migration
  def change
    create_table :bitsy_payment_depots do |t|
      t.decimal  :min_payment, null: false
      t.decimal  :initial_tax_rate, null: false
      t.decimal  :added_tax_rate, null: false
      t.decimal  :balance_cache, null: false
      t.string   :owner_address
      t.string   :address, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
      t.string   :tax_address
      t.string   :uuid, null: false
    end

    add_index :bitsy_payment_depots, :uuid
  end
end
