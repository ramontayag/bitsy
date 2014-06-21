require "rails-api"
require "sidekiq"
require "active_model_serializers"
require "bit_wallet"
require "clockwork"
require "daemons"
require "light-service"
require "uuidtools"
require "bitsy/engine"
require "bitsy/config"

module Bitsy
  require "bitsy/engine" if defined?(Rails)

  mattr_accessor :config

  def self.load_config(path)
    self.config = Config.new(path)
  end

  def self.configure
    yield self.config
  end

  def self.master_account
    bit_wallet.accounts.new(config.master_account_name)
  end

  def self.bit_wallet
    BitWallet.at(
      host: Bitsy.config.bitcoind.fetch(:host),
      port: Bitsy.config.bitcoind.fetch(:port),
      username: Bitsy.config.bitcoind.fetch(:username),
      password: Bitsy.config.bitcoind.fetch(:password),
      ssl: Bitsy.config.bitcoind.fetch(:ssl),
    )
  end

end
