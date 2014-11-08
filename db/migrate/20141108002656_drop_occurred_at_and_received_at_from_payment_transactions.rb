class DropOccurredAtAndReceivedAtFromPaymentTransactions < ActiveRecord::Migration
  def up
    remove_column :bitsy_payment_transactions, :occurred_at
    remove_column :bitsy_payment_transactions, :received_at
  end

  def down
    add_column :bitsy_payment_transactions, :occurred_at, :datetime, null: false
    add_column :bitsy_payment_transactions, :received_at, :datetime, null: false
  end
end
