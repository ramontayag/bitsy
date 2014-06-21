module Bitsy
  module V1
    class SyncsController < ApplicationController

      def create
        PaymentJob.new.perform
      end

    end
  end
end
