module Bitsy
  class BlockchainNotification < ActiveRecord::Base

    validates(
      :value,
      :transaction_hash,
      :input_address,
      :confirmations,
      presence: true
    )

  end
end
