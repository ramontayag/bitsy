module Bitsy
  class CreatePaymentDepot

    include LightService::Action
    expects :params
    promises :payment_depot

    executed do |ctx|
      wallet = InstantiateBlockchainWallet.execute.wallet

      params = ctx.params
      params[:address] = address = wallet.new_address.address
      params[:balance] = wallet.get_address(address)

      ctx.payment_depot = PaymentDepot.create(params)
    end

  end
end
