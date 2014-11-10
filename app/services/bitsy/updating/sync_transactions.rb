module Bitsy
  module Updating
    class SyncTransactions

      include LightService::Organizer

      def self.execute
        reduce(
          GetLatestBlock,
          SelectTransactions,
          UpdateTransactions,
        )
      end

    end
  end
end
