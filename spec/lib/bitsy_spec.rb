require "spec_helper"

describe Bitsy do

  describe ".load_config" do
    it "loads the memoizes bitsy config as .config" do
      config_path = Rails.root.join("config", "bitsy.yml")
      config = ::Bitsy::Config.new(config_path)
      original_id = described_class.load_config(config_path).object_id
      expect(described_class.config.bitcoind).to eq config.bitcoind
      expect(described_class.load_config(config_path).object_id).
        to eq original_id
    end
  end

  describe ".bit_wallet" do
    it "returns the BitWallet::Wallet instance that the app will use" do
      expect(BitWallet).to receive(:at).with(hash_including(
        host: Bitsy.config.bitcoind[:host],
        port: Bitsy.config.bitcoind[:port],
        username: Bitsy.config.bitcoind[:username],
        password: Bitsy.config.bitcoind[:password],
        ssl: Bitsy.config.bitcoind[:ssl],
      ))
      described_class.bit_wallet
    end
  end

  describe ".configure" do
    it "yields a block to configure Bitsy" do
      Bitsy.configure { |c| c.transaction_fee_threshold_multiplier = 2}
      expect(Bitsy.config.transaction_fee_threshold_multiplier).to eq 2
    end
  end

end
