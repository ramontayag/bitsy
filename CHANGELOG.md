# 0.2.1

- Do not retry certain jobs that may cause adverse effects

# 0.2.0

- Use blockchain.info instead of bitcoind

# 0.1.0

- Add `PaymentDepotsController#index` to see all payment depots

# 0.0.8

- Upgrade `bit_wallet`

# 0.0.7

- No longer use "" as the default master account because blockchain.info doesn't like it. Use "master" instead
- Add fix for issue with AMS [not serializing in controllers](https://github.com/rails-api/active_model_serializers/issues/600)

# 0.0.6

- Use BitcoinCleaner over BitcoinTestnet
- Upgrade `bit_wallet` to 0.7.3: do not rely on listaccounts because blockchain.info behaves differently compared to bitcoind

# 0.0.5

- Remove retry from Sidekiq job (do not want to DoS the server)

# 0.0.4

- Generate clockwork config file in `config/clock.rb` instead of `lib/clock.rb`

# 0.0.3

- Generate clockwork config file

# 0.0.2

- Add file matching gem name so bundler automatically loads this gem

# 0.0.1

Initial release
