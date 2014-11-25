require 'clockwork'
require "sidekiq"
require 'yaml'

RAILS_ENV = ENV['RAILS_ENV']
if RAILS_ENV.nil?
  fail ArgumentError, "clockwork must be started with RAILS_ENV"
end

bitsy_config_yml = File.join(File.dirname(__FILE__), "bitsy.yml")
CONFIG = YAML.load_file(bitsy_config_yml)[RAILS_ENV]

Sidekiq.configure_server do |config|
  config.redis = { url: CONFIG['redis_url'] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: CONFIG['redis_url'] }
end

module Clockwork
  handler do |job|
    Sidekiq::Client.push('class' => job, 'args' => [])
  end

  every(10.minutes, 'Bitsy::TransactionsSyncJob')
  every(15.minutes, 'Bitsy::ForwardJob')
end
