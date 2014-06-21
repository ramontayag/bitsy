require "bundler/setup"
Bundler.require(:defaults, :test, :development)
puts "Required inline testing"
require 'sidekiq/testing/inline'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = true
end

BitcoinTestnet.dir = File.join(SPEC_DIR, "testnet")
BitcoinTestnet.configure_with_rspec_and_vcr!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.use_transactional_fixtures = false

  config.before(:suite) do
    # Automigrate if needs migration
    if ActiveRecord::Migrator.needs_migration?
      ActiveRecord::Migrator.migrate(File.join(Rails.root, 'db/migrate'))
    end

    DatabaseCleaner.clean_with :truncation
    BitWallet.min_conf = 0
  end

end
