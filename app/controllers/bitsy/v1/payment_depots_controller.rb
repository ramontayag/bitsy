module Bitsy
  module V1
    class PaymentDepotsController < ApplicationController

      def index
        @payment_depots = PaymentDepot.all
        render json: @payment_depots
      end

      def show
        @payment_depot = PaymentDepot.find(params[:id])
        render json: @payment_depot
      end

      def create
        @payment_depot = CreatePaymentDepot.
          execute(params: payment_depot_params).
          payment_depot
        render json: @payment_depot
      end

      private

      def payment_depot_params
        params.require(:payment_depot).permit(
          :min_payment,
          :initial_tax_rate,
          :added_tax_rate,
          :owner_address,
          :tax_address,
        )
      end

    end
  end
end
