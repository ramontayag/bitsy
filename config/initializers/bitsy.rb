Bitsy.load_config Rails.root.join("config", "bitsy.yml")

Bitsy.configure do |c|
  # How much of a transaction fee to pay to the network
  c.transaction_fee = 0.0001

  # How much Bitcoin to accumulate before forwarding the money out
  c.transaction_fee_threshold_multiplier = 200

  # How many confirmations are needed to consider a transaction as complete
  c.safe_confirmation_threshold = 0

  # The name where all money is pooled before sending out. You will likely not
  # need to change this value.
  c.master_account_name = ""
end
