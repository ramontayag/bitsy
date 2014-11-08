$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bitsy/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bitsy-bitcoin"
  s.version     = Bitsy::VERSION
  s.authors     = ["Ramon Tayag"]
  s.email       = ["ramon.tayag@gmail.com"]
  s.homepage    = "https://github.com/ramontayag/bitsy"
  s.summary     = "A mountable Rails engine to create a Bitcoin payment server"
  s.description = "A mountable Rails engine to create a payment server that can handle the money in your Bitcoin ecosystem"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.0"
  s.add_dependency "rails-api", "0.2.1"
  s.add_dependency "sidekiq", "~> 2.8"
  s.add_dependency "active_model_serializers"
  s.add_dependency "bit_wallet", '0.7.6'
  s.add_dependency "clockwork", '0.7.2'
  s.add_dependency "daemons", "~> 1.1"
  s.add_dependency "light-service", "0.5.0"
  s.add_dependency "uuidtools", "~> 2.1"
  s.add_dependency "blockchain", "~> 1.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 2.14.2"
  s.add_development_dependency "capybara", "~> 2.0"
  s.add_development_dependency "vcr", "~> 2.4"
  s.add_development_dependency "webmock", ">= 1.8.0", "< 1.16"
  s.add_development_dependency "factory_girl_rails", "~> 4.2"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "bitcoin_cleaner", "1.0.0.beta.1"
  s.add_development_dependency "standalone_migrations"
  s.add_development_dependency "shoulda-matchers"
end
