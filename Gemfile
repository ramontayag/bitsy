source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'rails-api', '0.1.0'

gem 'app', '1.0.3'
gem 'sidekiq', '2.8.0'
gem 'sqlite3', '1.3.7'
gem 'unicorn', '4.6.2'

# NOTE: Override what gem is included until
# dcd70a686162fad41e5bd4bddc0ee67565227ec6 is released in rubygems
# bitcoin-client is used by bit_wallet
gem 'bitcoin-client', "0.0.3"

gem 'bit_wallet', '0.6.0'
gem 'clockwork', '0.5.0'
gem 'daemons', '1.1.9'
gem "light-service", "0.2.1"

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

group :development, :test do
  gem 'capistrano', '2.14.2'
  gem 'pry', '0.9.12'
  gem 'rspec-rails', '~> 2.13'
  gem 'capybara', '2.0.2'
  gem 'database_cleaner', '0.9.1'
  gem 'vcr', '~> 2.4'
  gem 'webmock', ">= 1.8.0", "< 1.16"
  gem 'bitcoin_testnet', '0.5.1'
  gem 'factory_girl_rails', '4.2.1'
end
