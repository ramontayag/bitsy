require "spec_helper"

module Bitsy
  module V1
    describe BlockchainNotificationsController do
      routes { Bitsy::Engine.routes }

      describe "GET #index" do
        let(:secret) { Bitsy.config.blockchain_secrets.sample }
        let(:payment_depot) do
          create(:payment_depot, {
            address: "receiving_address",
          })
        end
        let(:params) do
          {
            value: 1_800_991,
            transaction_hash: "transaction_hash",
            input_address: payment_depot.address,
            confirmations: 1,
            secret: secret,
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
            secret: secret,
          )
        end

        it "is a status of 200" do
          get :index, params
          expect(response.status).to eq 200
        end

        it "enqueues BlockchainNotificationJob" do
          blockchain_notification = double(BlockchainNotification, id: 2)
          allow(BlockchainNotification).to receive(:new).
            and_return(blockchain_notification)
          allow(blockchain_notification).to receive(:save).and_return(true)
          expect(BlockchainNotificationJob).to receive(:perform_async).with(2)
          get :index, params
        end

        context "error creating" do
          it "does not respond with 200" do
            get :index
            expect(response.status).to_not eq 200
          end
        end
      end

    end
  end
end
