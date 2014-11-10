module Bitsy
  module V1
    class SyncsController < ApplicationController

      def create
        TransactionsSyncJob.new.perform
      end

    end
  end
end
