source 'https://rubygems.org'

gem 'rails', '3.2.13'
gem 'rails-api', '0.1.0'
gem 'app', '1.0.3'
# Override what gem is included until dcd70a686162fad41e5bd4bddc0ee67565227ec6
# is released in rubygems
gem('bitcoin-client',
    git: 'git@github.com:sinisterchipmunk/bitcoin-client.git',
    ref: 'dcd70a686162fad41e5bd4bddc0ee67565227ec6')
gem 'bit_wallet', '0.4.0'
gem 'sidekiq', '2.7.5'
gem 'sqlite3', '1.3.7'
gem 'unicorn', '4.6.2'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

group :development, :test do
  gem 'capistrano', '2.14.2'
  gem 'pry', '0.9.12'
  gem 'rspec-rails', '2.13.0'
  gem 'capybara', '2.0.2'
  gem 'database_cleaner', '0.9.1'
  gem 'vcr', '2.4.0'
  gem 'webmock', '1.9.3'
  gem 'bitcoin_testnet', '0.4.0'
  gem 'factory_girl_rails', '4.2.1'
end
