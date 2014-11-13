Bitsy.load_config Rails.root.join("config", "bitsy.yml")

Bitsy.configure do |c|
  # How much of a transaction fee to pay to the network
  c.transaction_fee = 0.0001

  # How much Bitcoin to accumulate before forwarding the money out
  c.transaction_fee_threshold_multiplier = 200

  # How many confirmations are needed to consider a transaction as complete
  c.safe_confirmation_threshold = 0

  # List of allowed secrets from Blockchain.info. The callback URL should look
  # like this http://app.com/bitsy/v1/blockchain_notifications?secret=mysecret
  c.blockchain_secrets = %w(secret)
end

Sidekiq.configure_server do |config|
  config.redis = { url: Bitsy.config.redis_url }
end

Sidekiq.configure_client do |config|
  config.redis = { url: Bitsy.config.redis_url }
end
