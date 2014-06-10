require "spec_helper"

module Bitsy
  module V1
    describe TruncationsController do
      routes { Bitsy::Engine.routes }

      describe "POST create" do
        it "clears the database" do
          expect(DatabaseCleaner).to receive(:clean_with).with(:truncation)
          post :create
        end
      end

    end
  end
end
