App.configure do
  config.testnet_dir = File.join(Rails.root, 'spec', 'testnet')
  config.testnet = OpenStruct.new
  config.testnet.started_externally = false
  config.safe_confirmation_threshold = 0
end
