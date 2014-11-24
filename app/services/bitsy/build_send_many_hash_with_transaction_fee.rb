module Bitsy
  class BuildSendManyHashWithTransactionFee

    include LightService::Organizer
    include LightService::Action
    expects :payment_transactions, :transaction_fee

    executed do |ctx|
      with(ctx).reduce(ComputeAmountForSplitting, BuildSendManyHash)
    end

  end
end
