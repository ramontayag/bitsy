require "rails-api"
require "sidekiq"
require "active_model_serializers"
require "bit_wallet"
require "clockwork"
require "daemons"
require "light-service"
require "uuidtools"
require "blockchain"
require "bitsy/engine"
require "bitsy/config"

module Bitsy
  require "bitsy/engine" if defined?(Rails)

  mattr_accessor :config

  def self.load_config(path)
    self.config ||= Config.new(path)
  end

  def self.configure
    yield self.config
  end

end
