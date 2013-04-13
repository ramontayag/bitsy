Bundler.require(:test)
puts "Required inline testing"
require 'sidekiq/testing/inline'

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.allow_http_connections_when_no_cassette = true
end

BitcoinTestnet.dir = 'spec/testnet'
BitcoinTestnet.configure_with_rspec_and_vcr!

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with :truncation
    BitWallet.config.min_conf = 0
  end
end
