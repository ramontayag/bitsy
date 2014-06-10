require "spec_helper"

describe Bitsy do

  describe ".load_config" do
    it "loads the bitsy config and keeps and instance of the config in .config" do
      config_path = Rails.root.join("config", "bitsy.yml")
      config = ::Bitsy::Config.new(config_path)
      described_class.load_config(config_path)
      expect(described_class.config.bitcoind).to eq config.bitcoind
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

  describe ".master_account", vcr: {record: :once} do
    it "returns the BitWallet::Account of the master account" do
      account = described_class.master_account
      expect(account).to be_a BitWallet::Account
      expect(account.name).to eq Bitsy.config.master_account_name
    end
  end

  describe ".configure" do
    it "yields a block to configure Bitsy" do
      Bitsy.configure { |c| c.master_account_name = "mister" }
      expect(Bitsy.config.master_account_name).to eq "mister"
    end
  end

end
