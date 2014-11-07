require "spec_helper"

module Bitsy
  module V1
    describe BlockchainNotificationsController do
      routes { Bitsy::Engine.routes }

      describe "GET #index" do
        let(:params) do
          {
            value: 1_800_991,
            transaction_hash: "transaction_hash",
            input_address: "receiving_address",
            confirmations: 1,
            secret: "sekret",
          }
        end

        it "creates a blockchain notification with the given params" do
          get :index, params
          notification = BlockchainNotification.
            find_by(transaction_hash: "transaction_hash")
          expect(notification.attributes.with_indifferent_access).to include(
            value: 1_800_991,
            transaction_hash: "transaction_hash",
            input_address: "receiving_address",
            confirmations: 1,
            secret: "sekret",
          )
        end

        it "is a status of 200" do
          get :index, params
          expect(response.status).to eq 200
        end
      end

    end
  end
end
