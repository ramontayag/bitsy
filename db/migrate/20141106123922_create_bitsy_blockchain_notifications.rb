class CreateBitsyBlockchainNotifications < ActiveRecord::Migration
  def change
    create_table :bitsy_blockchain_notifications do |t|
      t.integer :value, null: false
      t.string :transaction_hash, null: false
      t.string :input_address, null: false
      t.integer :confirmations, null: false, default: 0
      t.string :secret, null: false
    end
  end
end
