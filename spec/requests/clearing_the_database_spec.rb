require "spec_helper"

describe "Clearing the database", vcr: {record: :once}, bitcoin_cleaner: true do

  it "clears the database" do
    create(:payment_transaction, payment_depot_id: 1)
    expect(Bitsy::PaymentTransaction.count).to_not be_zero
    post bitsy.v1_truncations_path
    expect(Bitsy::PaymentTransaction.count).to be_zero
  end

end
