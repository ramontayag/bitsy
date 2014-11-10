require "spec_helper"

describe Bitsy do

  describe ".load_config" do
    it "loads the memoizes bitsy config as .config" do
      config_path = Rails.root.join("config", "bitsy.yml")
      config = ::Bitsy::Config.new(config_path)
      original_id = described_class.load_config(config_path).object_id
      expect(described_class.config.blockchain).to eq config.blockchain
      expect(described_class.load_config(config_path).object_id).
        to eq original_id
    end
  end

  describe ".configure" do
    it "yields a block to configure Bitsy" do
      Bitsy.configure { |c| c.transaction_fee_threshold_multiplier = 2}
      expect(Bitsy.config.transaction_fee_threshold_multiplier).to eq 2
    end
  end

end
