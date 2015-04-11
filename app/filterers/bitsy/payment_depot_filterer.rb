module Bitsy
  class PaymentDepotFilterer < Filterer::Base

    def starting_query
      PaymentDepot.all
    end

    def param_id(x)
      @results.where(id: x)
    end

  end
end
