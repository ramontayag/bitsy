require "spec_helper"

module Bitsy
  module V1
    describe PaymentDepotsController do
      routes { Bitsy::Engine.routes }

      describe "POST /payment_depots" do
        it "creates a payment depot and returns its details" do
          payment_depot = build_stubbed(:payment_depot)
          params = { min_payment: "0.5",
                     initial_tax_rate: "0.8",
                     added_tax_rate: "0.1",
                     owner_address: "x9s9319",
                     tax_address: "tax2388" }
          expect(PaymentDepot).to receive(:create).
            with(hash_including(params)) { payment_depot }

          post :create, payment_depot: params
          json = JSON.parse(response.body).with_indifferent_access[:payment_depot]
          expect(json[:id]).to eq payment_depot.id
        end
      end

    end
  end
end
