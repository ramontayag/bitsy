source 'https://rubygems.org'

gem "rails", "4.0.4"
gem "rails-api", "0.2.0"

gem "app", "~> 1.0"
gem "sidekiq", "~> 2.8"
gem "sqlite3", "~> 1.3"
gem 'unicorn', "4.6.2"
gem "active_model_serializers"

gem 'bit_wallet', '0.6.1'
gem 'clockwork', '0.7.2'
gem 'daemons', "~> 1.1"
gem "light-service", "0.2.1"

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

group :development, :test do
  gem 'capistrano', '~> 2.14'
  gem 'pry', '0.9.12'
end

group :development do
  gem "spring", "~> 1.1"
  gem "spring-commands-rspec", "~> 1.0"
end

group :test do
  gem 'rspec-rails', '~> 2.13'
  gem 'capybara', '~> 2.0'
  gem 'database_cleaner', "~> 1.2"
  gem 'vcr', '~> 2.4'
  gem 'webmock', ">= 1.8.0", "< 1.16"
  gem 'bitcoin_testnet', '0.5.1'
  gem 'factory_girl_rails', "~> 4.2"
end
