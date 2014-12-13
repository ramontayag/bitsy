module Bitsy
  class BlockchainNotification < ActiveRecord::Base

    attr_reader :test

    validates(
      :value,
      :transaction_hash,
      :input_address,
      :confirmations,
      presence: true
    )

    validates(:secret, inclusion: {in: Bitsy.config.blockchain_secrets})

    def test=(b)
      @test = ["true", true].include?(b)
    end

  end
end
