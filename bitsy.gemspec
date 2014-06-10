$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "bitsy/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "bitsy"
  s.version     = Bitsy::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Bitsy."
  s.description = "TODO: Description of Bitsy."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.1.1"
  s.add_dependency "sidekiq", "~> 2.8"
  s.add_dependency "sidekiq", "~> 2.8"
  s.add_dependency "active_model_serializers"
  s.add_dependency "bit_wallet", '0.6.1'
  s.add_dependency "clockwork", '0.7.2'
  s.add_dependency "daemons", "~> 1.1"
  s.add_dependency "light-service", "0.2.1"
  s.add_dependency "uuidtools", "~> 2.1"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", "~> 2.13"
  s.add_development_dependency "capybara", "~> 2.0"
  s.add_development_dependency "vcr", "~> 2.4"
  s.add_development_dependency "webmock", ">= 1.8.0", "< 1.16"
  s.add_development_dependency "bitcoin_testnet", "0.5.1"
  s.add_development_dependency "factory_girl_rails", "~> 4.2"
end
