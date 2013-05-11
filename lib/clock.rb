require 'clockwork'
require './../config/boot'
require './../config/environment'

module Clockwork
  handler do |job|
    puts "Running #{job}"
  end

  every(5.seconds, 'dispatcher') { DispatchWorker.async_perform }
  # every(1.second, 'dispatcher') { DispatchWorker.async_perform }
end
