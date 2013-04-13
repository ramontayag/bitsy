class CreatePaymentTransactions < ActiveRecord::Migration
  def change
    create_table :payment_transactions do |t|
      t.references :payment_depot, null: false
      t.decimal :amount, null: false
      t.string :receiving_address, null: false
      t.string :payment_type, null: false
      t.string :transaction_id, null: false
      t.string :forwarding_transaction_id
      t.datetime :occurred_at, null: false
      t.datetime :received_at, null: false
      t.timestamps
    end
  end
end
