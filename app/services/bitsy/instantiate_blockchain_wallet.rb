module Bitsy
  class InstantiateBlockchainWallet

    include LightService::Action
    promises :wallet

    executed do |ctx|
      config = Bitsy.config.blockchain
      ctx.wallet = Blockchain::Wallet.new(
        config[:identifier],
        config[:password],
        config[:second_password],
        config[:api_code],
      )
    end

  end
end
