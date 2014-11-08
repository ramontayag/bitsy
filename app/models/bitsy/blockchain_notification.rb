module Bitsy
  class BlockchainNotification < ActiveRecord::Base

    validates(
      :value,
      :transaction_hash,
      :input_address,
      :confirmations,
      presence: true
    )

    validates(:secret, inclusion: {in: Bitsy.config.blockchain_secrets})

  end
end
