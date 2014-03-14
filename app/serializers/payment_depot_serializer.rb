class PaymentDepotSerializer < ActiveModel::Serializer

  attributes(
    :min_payment_received,
    :total_received_amount
  )

  def min_payment_received
    object.min_payment_received?
  end

end
