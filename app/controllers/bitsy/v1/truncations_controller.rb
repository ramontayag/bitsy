module Bitsy
  module V1
    class TruncationsController < ApplicationController

      def create
        DatabaseCleaner.clean_with :truncation
      end

    end
  end
end
