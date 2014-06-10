module Bitsy
  class PaymentDepotSerializer < ActiveModel::Serializer

    attributes(
      :id,
      :min_payment_received,
      :total_received_amount,
      :address,
    )

    def min_payment_received
      object.min_payment_received?
    end

  end
end
