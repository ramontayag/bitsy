require "spec_helper"

module V1
  describe SyncsController do

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
