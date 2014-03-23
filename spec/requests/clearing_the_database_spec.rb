require "spec_helper"

describe "Clearing the database", vcr: {record: :once} do

  it "clears the database" do
    create(:payment_transaction, payment_depot_id: 1)
    expect(PaymentTransaction.count).to_not be_zero
    post v1_truncations_path
    expect(PaymentTransaction.count).to be_zero
  end

end
