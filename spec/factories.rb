FactoryGirl.define do

  factory :payment_depot do
    min_payment 2
    initial_tax_rate 0.5
    added_tax_rate 0.03
  end

  factory :payment_transaction do
    payment_depot
    amount 1.345
    receiving_address 'the address that received the money'
  end

  factory :bit_wallet, :class => OpenStruct do
  end

  factory :bit_wallet_account, :class => OpenStruct do
    sequence(:name) {|n| n.to_s}
    addresses do |account|
      [FactoryGirl.build(:bit_wallet_address, account: account)]
    end
  end

  factory :bit_wallet_address, :class => OpenStruct do
    account { FactoryGirl.build(:bit_wallet_account) }
    sequence(:address) {|n| "address_#{n+1000}"}
  end

  factory :bit_wallet_transaction, :class => OpenStruct do
    account { FactoryGirl.build(:bit_wallet_account) }
    sequence(:id) {|n| "longhash_#{n}"}
    sequence(:address_str) {|n| "address_#{n}"}
    amount 1.22
    category 'receive'
    confirmations 0
    occurred_at 1.minute.ago
    received_at 1.minute.ago
  end

end
