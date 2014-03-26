require "spec_helper"

describe "Payment depot management", vcr: {record: :once} do
  let(:wallet) { App.bit_wallet }

  let(:default_account) { App.bitcoin_master_account }
  let(:buyer_account) { wallet.accounts.new('buyer') }
  let(:buyer_address) { buyer_account.addresses.first.address }

  let(:taxer_account) { wallet.accounts.new('taxer') }
  let(:taxer_address) { taxer_account.addresses.first.address }

  let(:owner_account) { wallet.accounts.new('owner') }
  let(:owner_address) { owner_account.addresses.first.address }

  before do
    # Transfer money from default account to the buyer, so the buyer can buy
    default_account.send_amount 10, to: buyer_address
  end

  it "creates a payment depot to monitor payments" do
    # Must create payment depot through a factory and define the uuid
    payment_depot = create(
      :payment_depot,
      min_payment: 2.0,
      initial_tax_rate: 0.8,
      added_tax_rate: 0.1,
      owner_address: owner_address,
      tax_address: taxer_address,
      uuid: "sowealwaysfetchthesameaddress",
    )

    # Buyer pays
    buyer_account.send_amount 2.0, to: payment_depot.address

    post v1_syncs_path

    expect(taxer_account.balance).to eq(1.6) # 0.8 * 2.0
    expect(owner_account.balance).to eq(0.4) # 0.2 * 2.0

    get v1_payment_depot_path(payment_depot)

    json = JSON.parse(response.body).with_indifferent_access[:payment_depot]

    expect(json[:total_received_amount]).to eq "2.0"
  end

end
