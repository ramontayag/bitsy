# This migration comes from bitsy (originally 20140607015859)
class CreateBitsyPaymentTransactions < ActiveRecord::Migration
  def change
    create_table :bitsy_payment_transactions do |t|
      t.references :payment_depot, null: false
      t.decimal :amount, null: false
      t.string :receiving_address, null: false
      t.string :payment_type, null: false
      t.integer :confirmations, null: false
      t.string :transaction_id, null: false
      t.string :forwarding_transaction_id
      t.datetime :occurred_at, null: false
      t.datetime :received_at, null: false
      t.integer :confirmations, null: false, default: 0
      t.timestamps
    end
  end
end
