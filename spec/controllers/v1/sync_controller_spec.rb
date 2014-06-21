require "spec_helper"

module Bitsy
  module V1
    describe SyncsController do
      routes { Bitsy::Engine.routes }

      describe "POST #create" do
        it "responds with successful 200" do
          payment_job = double
          allow(PaymentJob).to receive(:new) { payment_job }
          expect(payment_job).to receive(:perform)

          post :create
          expect(response.status).to eq 200
        end
      end

    end
  end
end
