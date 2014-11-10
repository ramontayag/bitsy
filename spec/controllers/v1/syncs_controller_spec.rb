require "spec_helper"

module Bitsy
  module V1
    describe SyncsController do
      routes { Bitsy::Engine.routes }

      describe "POST #create" do
        it "responds with successful 200" do
          job = double(TransactionsSyncJob)
          allow(TransactionsSyncJob).to receive(:new) { job }
          expect(job).to receive(:perform)

          post :create
          expect(response.status).to eq 200
        end
      end

    end
  end
end
