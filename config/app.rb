class App < Configurable # :nodoc:
  # Settings in config/app/* take precedence over those specified here.
  config.name = Rails.application.class.parent.name

  config.tax_address = '115odcfXHs6rPGj2akdwQBFdQZSMRwemzb'

  config.bitcoind_username = 'admin1'
  config.bitcoind_password = '123'
  config.bitcoind_port = 19001

  config.bit_wallet = BitWallet.at(username: App.bitcoind_username,
                                   password: App.bitcoind_password,
                                   port: App.bitcoind_port)

  config.bitcoin_master_account_name = ''
  config.bitcoin_master_account = -> {
    puts "Instantiating the master account"
    config.bit_wallet.accounts.new(config.bitcoin_master_account_name)
  }

  # This is the transaction fee that bitcoind will set.
  # TODO: find a way to programatically get this so Bitsy will be more robust to
  # to changes in the fee in the future.
  config.transaction_fee = 0.0005
  config.transaction_fee_threshold_multiplier = 200
  config.forward_threshold = config.transaction_fee * transaction_fee_threshold_multiplier
  config.safe_confirmation_threshold = 6
end
