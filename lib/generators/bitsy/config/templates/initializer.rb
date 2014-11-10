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
end
