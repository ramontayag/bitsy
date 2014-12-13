module Bitsy
  class GetLatestBlock

    include LightService::Action
    promises :latest_block

    executed do |ctx|
      ctx.latest_block = Blockchain.get_latest_block
    end

  end
end
