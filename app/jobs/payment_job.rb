class PaymentJob

  include Sidekiq::Worker

  def perform
    ProcessesPayments.for(App.bit_wallet,
                          App.bitcoin_master_account)
  end

end
