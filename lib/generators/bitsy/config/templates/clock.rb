require 'clockwork'
require "sidekiq"

module Clockwork
  handler do |job|
    Sidekiq::Client.push('class' => job, 'args' => [])
  end

  every(10.minutes, 'Bitsy::TransactionsUpdateJob')
end
