class AddConfirmationsToPaymentTransaction < ActiveRecord::Migration
  def change
    add_column :payment_transactions, :confirmations, :integer, null: false, default: 0
  end
end
