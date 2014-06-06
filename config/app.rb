class App < Configurable # :nodoc:
  # Settings in config/app/* take precedence over those specified here.
  config.name = Rails.application.class.parent.name

  # TODO: Remove when Rails 4.1 comes with built-in support for secrets
  config.secrets_file_path = Rails.root.join("config", "secrets.yml")
  config.secrets = YAML.load_file(secrets_file_path).
    with_indifferent_access[Rails.env]

  config.bitcoind_host = App.secrets.fetch(:bitcoind).fetch(:host)
  config.bitcoind_port = App.secrets.fetch(:bitcoind).fetch(:port)
  config.bitcoind_username = App.secrets.fetch(:bitcoind).fetch(:username)
  config.bitcoind_password = App.secrets.fetch(:bitcoind).fetch(:password)
  config.bitcoind_ssl = App.secrets.fetch(:bitcoind).fetch(:ssl)

  config.bit_wallet = BitWallet.at(
    host: App.bitcoind_host,
    port: App.bitcoind_port,
    username: App.bitcoind_username,
    password: App.bitcoind_password,
    ssl: App.bitcoind_ssl,
  )

  config.bitcoin_master_account_name = ''
  config.bitcoin_master_account = -> {
    config.bit_wallet.accounts.new(config.bitcoin_master_account_name)
  }

  # This is the transaction fee that bitcoind will set.
  # TODO: find a way to programatically get this so Bitsy will be more robust to
  # to changes in the fee in the future.
  config.transaction_fee = App.secrets.fetch(:transaction_fee)
  config.transaction_fee_threshold_multiplier =
    App.secrets.fetch(:transaction_fee_threshold_multiplier)
  config.forward_threshold = config.transaction_fee * transaction_fee_threshold_multiplier
  config.safe_confirmation_threshold = 0
end
