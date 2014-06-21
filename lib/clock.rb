require 'clockwork'
require "sidekiq"

module Clockwork
  handler do |job|
    Sidekiq::Client.push('class' => job, 'args' => [])
  end

  every(5.seconds, 'Bitsy::PaymentJob')
end
