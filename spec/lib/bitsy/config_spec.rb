require "spec_helper"

module Bitsy
  describe Config do
    let(:config_path) do
      "lib/generators/bitsy/config/templates/bitsy.yml"
    end

    describe ".new" do
      it "loads the config of the environment with indifferent access" do
        expected_config = YAML.load_file(config_path).
          with_indifferent_access[:test]

        resulting_config = described_class.new(config_path)

        expected_config.each do |key, value|
          expect(resulting_config.send(key)).to eq value
        end

        expect(resulting_config.bitcoind[:host]).
          to eq expected_config["bitcoind"]["host"]
      end
    end

    describe "#transaction_fee=" do
      it "sets #transaction_fee" do
        config = described_class.new(config_path)
        config.transaction_fee = 23.2
        expect(config.transaction_fee).to eq 23.2
      end
    end

    describe "#transaction_fee_threshold_multiplier=" do
      it "sets #transaction_fee_threshold_multiplier" do
        config = described_class.new(config_path)
        config.transaction_fee_threshold_multiplier = 2
        expect(config.transaction_fee_threshold_multiplier).to eq 2
      end
    end

    describe "#safe_confirmation_threshold=" do
      it "sets #safe_confirmation_threshold" do
        config = described_class.new(config_path)
        config.safe_confirmation_threshold = 1
        expect(config.safe_confirmation_threshold).to eq 1
      end
    end

    describe "#master_account_name=" do
      it "sets #master_account_name" do
        config = described_class.new(config_path)
        config.master_account_name = "master"
        expect(config.master_account_name).to eq "master"
      end
    end

    describe "#forward_threshold" do
      it "is transaction_fee * transaction_fee_threshold_multiplier" do
        config = described_class.new(config_path)
        config.transaction_fee = 22.0
        config.transaction_fee_threshold_multiplier = 2
        expected_value = 44.0
        expect(config.forward_threshold).to eq(expected_value)
      end
    end

  end
end
