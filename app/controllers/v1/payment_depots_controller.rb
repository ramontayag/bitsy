module V1
  class PaymentDepotsController < ApplicationController

    def show
      @payment_depot = PaymentDepot.find(params[:id])
      render json: @payment_depot
    end

    def create
      @payment_depot = PaymentDepot.create(payment_depot_params)
      render json: @payment_depot
    end

    private

    def payment_depot_params
      params.require(:payment_depot).permit(
        :min_payment,
        :initial_tax_rate,
        :added_tax_rate,
        :owner_address
      )
    end

  end
end
