module Bitsy
  class PaymentDepotSerializer < ActiveModel::Serializer

    attributes(
      :id,
      :min_payment_received,
      :total_received_amount,
      :address,
      :min_payment,
      :total_tax_sent,
      :total_owner_sent,
      :forwarding_transaction_fee,
    )

    def min_payment_received
      object.min_payment_received?
    end

  end
end
