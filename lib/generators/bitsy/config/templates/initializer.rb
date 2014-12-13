Bitsy.load_config Rails.root.join("config", "bitsy.yml")

Bitsy.configure do |c|
  # How much of a transaction fee to pay to the network
  c.transaction_fee = 0.0001

  # This setting multiplied by the transaction fee is how much bitcoin the
  # system will accumulate before forwarding money
  c.transaction_fee_threshold_multiplier = 200

  # How many confirmations are needed to consider a transaction as complete
  c.safe_confirmation_threshold = 0

  # List of allowed secrets from Blockchain.info. The callback URL should look
  # like this http://app.com/bitsy/v1/blockchain_notifications?secret=mysecret
  c.blockchain_secrets = %w(secret)

  # Write out the payment transactions, addresses, and other details. These
  # transactions are the ones being forwarded.
  c.send_many_log_path = Rails.root.join("log", "send_many.log")

  # WHen debug is true, no money will be forwarded. This is for testing
  # purposes.
  c.debug = false

  # Bitsy will check the transactions of the payment depot manually if it hasn't
  # been paid for yet. It will check 40 times, in approximately check count ** 2
  # power intervals. Ex: check_count = 3, then it will check again in 9 seconds.
  c.check_limit = 40
end

Sidekiq.configure_server do |config|
  config.redis = { url: Bitsy.config.redis_url }
end

Sidekiq.configure_client do |config|
  config.redis = { url: Bitsy.config.redis_url }
end
