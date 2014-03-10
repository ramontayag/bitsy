require "spec_helper"

describe "Payment depoy management", vcr: {record: :once} do
  let(:wallet) { App.bit_wallet }

  let(:default_account) { App.bitcoin_master_account }
  let(:buyer_account) { wallet.accounts.new('buyer') }
  let(:buyer_address) { buyer_account.addresses.first.address }

  let(:taxer_account) { wallet.accounts.new('taxer') }
  let(:taxer_address) { taxer_account.addresses.first.address }

  let(:owner_account) { wallet.accounts.new('owner') }
  let(:owner_address) { owner_account.addresses.first.address }

  before do
    allow(App).to receive(:tax_address) { taxer_address }
    # Transfer money from default account to the buyer, so the buyer can buy
    default_account.send_amount 10, to: buyer_address
  end

  it "creates a payment depot to receive payments" do
    payment_depot_params = { min_payment: 2.0,
                             initial_tax_rate: 0.8,
                             added_tax_rate: 0.1,
                             owner_address: owner_address }
    post v1_payment_depots_path(payment_depot: payment_depot_params)

    # Buyer pays
    payment_depot = PaymentDepot.find_by_owner_address(owner_address)
    buyer_account.send_amount 2.0, to: payment_depot.address

    PaymentJob.new.perform

    expect(taxer_account.balance).to eq(1.6) # 0.8 * 2.0
    expect(owner_account.balance).to eq(0.4) # 0.2 * 2.0
  end

end
