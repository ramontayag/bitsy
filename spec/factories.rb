FactoryGirl.define do

  factory :blockchain_notification, class: Bitsy::BlockchainNotification do
    value 1.2
    sequence(:transaction_hash) {|n| "transaction_hash_#{n}"}
    input_address "input_address"
    confirmations 1
    secret "secret"
  end

  factory :blockchain_latest_block, class: Blockchain::LatestBlock do
    hash "block_hash"
    time Time.now.to_i
    block_index 188288
    height 828282
    txIndexes []
    initialize_with do
      Blockchain::LatestBlock.new(attributes.with_indifferent_access)
    end
  end

  factory :blockchain_payment_response, class: Blockchain::PaymentResponse do
    message nil
    tx_hash "transaction_hash"
    notice nil
    initialize_with {Blockchain::PaymentResponse.new(message, tx_hash, notice)}
  end

  factory :blockchain_transaction, class: Blockchain::Transaction do
    sequence(:hash) { |n| "transaction_hash_#{n}" }
    inputs []
    out []
    block_height 1002020
    initialize_with do
      Blockchain::Transaction.new(attributes.with_indifferent_access)
    end
  end

  factory :blockchain_output, class: Blockchain::Output do
    sequence(:n) { |n| n }
    value 1_000_000
    addr "output_address"
    tx_index "tx_index"
    script "tx_script"
    spent "spent"
    initialize_with do
      Blockchain::Output.new(attributes.with_indifferent_access)
    end
  end

  factory :blockchain_wallet, class: Blockchain::Wallet do
    identifier "identifier"
    password "pass"
    second_password "second pass"
    api_code "api_code"
    initialize_with do
      Blockchain::Wallet.new(
        attributes[:identifier],
        attributes[:password],
        attributes[:second_password],
        attributes[:api_code],
      )
    end
  end

  factory :blockchain_address, class: Blockchain::Address do
    sequence(:hash160) { |n| "hash_160-#{n}" }
    address "address"
    n_tx "n_tx"
    total_received 80023
    total_sent 2122
    final_balance 80023 - 2122
    transactions []
    initialize_with do
      attrs = attributes.with_indifferent_access
      attrs[:txs] = attrs.delete(:transactions)
      Blockchain::Address.new(attrs)
    end
  end

  factory :blockchain_wallet_address, class: Blockchain::WalletAddress do
    balance 0.005
    sequence(:address) { |n| "address_#{n}"}
    label nil
    total_received 0.005
    initialize_with do
      Blockchain::WalletAddress.new(
        attributes[:balance],
        attributes[:address],
        attributes[:label],
        attributes[:total_received],
      )
    end
  end

  factory :payment_depot, class: "Bitsy::PaymentDepot" do
    sequence(:address) {|n| "fake address #{n}" }
    min_payment 2
    initial_tax_rate 0.5
    added_tax_rate 0.03
    owner_address "the address of the owner"
    tax_address "address where the tax money goes"
  end

  factory :payment_transaction, class: "Bitsy::PaymentTransaction" do
    payment_depot
    amount 1.345
    receiving_address 'the address that received the money'
    payment_type "receive"
    transaction_id "xx1"
  end

end
