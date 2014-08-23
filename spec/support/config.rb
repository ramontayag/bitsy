require "bundler/setup"
Bundler.require(:defaults, :test, :development)
puts "Required inline testing"
require 'sidekiq/testing/inline'

SPEC_CONFIG = YAML.load_file(File.join(SPEC_DIR, "config.yml")).
  with_indifferent_access

BitcoinCleaner.dir = SPEC_CONFIG.fetch(:bitcoin_dir)
BitcoinCleaner.configure_with_rspec_and_vcr!

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = true
end

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
