require 'spec_helper'

describe "Bitcoin flow", vcr: {record: :all} do
  let(:wallet) do
    App.bit_wallet
  end
  let(:default_account) { App.bitcoin_master_account }
  let(:buyer_account) { wallet.accounts.new('buyer') }
  let(:taxer_account) { wallet.accounts.new('taxer') }
  let(:owner_account) { wallet.accounts.new('owner') }

  before do
    # Transfer money from default account to the buyer, so the buyer can buy
    default_account.send_amount 10, to: buyer_account.addresses.first.address
  end

  it 'should pay the tax collector, and the owner' do
    # Someone attempts to purchase, so a payment depot is created
    payment_depot = create(:payment_depot,
                           min_payment: 1.5,
                           initial_tax_rate: 0.8,
                           added_tax_rate: 0.05)
    puts "This is the payment depot: #{payment_depot.inspect}"

    # Buyer pays
    buyer_account.send_amount 1.5, to: payment_depot.address

    PaymentJob.run

    taxer_account.balance.should == 0.8 * 1.5
    owner_account.balance.should == 0.2 * 1.5
  end

end
