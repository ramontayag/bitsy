# 0.9.0

- `/api/v0/payment_depots` endpoint now serializes
  - `#total_tax_sent` (method also fixed)
  - `#total_owner_sent` (method also fixed)
  - `#forwarding_transaction_fee`
- Add `PaymentTransaction.debits` scope which returns all forwarding transactions

# 0.8.4

- Fix arguments for `#send_many`

# 0.8.3

- Follow the `check_limit`

# 0.8.2

- Use `Blockchain::Address.transactions` and not `.txs`

# 0.8.1

- Check payment depots whose `checked_at` has not been seen

# 0.8.0

- Only fetch the latest block when checking for payments if there are payment depots we need to check

# 0.7.1

- Ensure that only payment depots that ought to be checked are checked

# 0.7.0

- if `test: true` is passed in the parameters for the blockchain notification, then "*ok*" is returned. This should have always been the case.
- Manually check addresses that haven't received payments yet.

# 0.6.1

- Properly respond with "*ok*" to successful BlockchainNotificationsController requests

# 0.6.0

- Log transaction fee in `send_many.log`

# 0.5.5

- Change `total_received_amount` to decimal to avoid comparison issues. Migration needed.

# 0.5.4

- Run ForwardJob every 15 minutes

# 0.5.3

- Fix wrongly computed transaction confirmations

# 0.5.2

- Do not retry TransactionsSyncJob if it fails

# 0.5.1

- Fix wrong library name in `clock.rb` template

# 0.5.0

- Take transaction fee from the bitcoin being sent out
- Add `debug` to the Bitsy config
- Add a separate logger for the `send_many` hash

# 0.4.0

- Cache `PaymentDepot#total_received_amount` in `total_received_amount_cache`. Migration must be run.

# 0.3.2

- Fix wrong job name in `clock.rb`

# 0.3.1

- Load correct `redis_url` for clockwork

# 0.3.0

- Add redis url settings to settings.yml

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
