class PaymentJob

  include Sidekiq::Worker

  def perform
    ProcessesPayments.for(App.bit_wallet)
  end

end
