require "spec_helper"

module Bitsy
  module V1
    describe PaymentDepotsController do
      routes { Bitsy::Engine.routes }

      describe "GET /payment_depots" do
        it "returns a list of all payment depots" do
          create(:payment_depot, address: "xyz")
          get :index
          json = JSON.parse(response.body).with_indifferent_access
          payment_depots_json = json.fetch(:payment_depots)
          expect(payment_depots_json.count).to eq 1
          expect(payment_depots_json.first[:address]).to eq "xyz"
        end
      end

      describe "POST /payment_depots" do
        it "creates a payment depot and returns its details" do
          payment_depot = build_stubbed(:payment_depot)
          resulting_ctx = double(LightService::Context, {
            payment_depot: payment_depot,
          })
          params = { min_payment: "0.5",
                     initial_tax_rate: "0.8",
                     added_tax_rate: "0.1",
                     owner_address: "x9s9319",
                     tax_address: "tax2388" }.with_indifferent_access
          expect(CreatePaymentDepot).to receive(:execute).
            with(params: params).and_return(resulting_ctx)

          post :create, payment_depot: params
          json = JSON.parse(response.body).with_indifferent_access[:payment_depot]
          expect(json[:id]).to eq payment_depot.id
        end
      end

    end
  end
end
