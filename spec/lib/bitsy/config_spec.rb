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
      it "sets confirmation threshold that determines whether or not the payment depots are paid" do
        config = described_class.new(config_path)
        config.safe_confirmation_threshold = 1
        expect(config.safe_confirmation_threshold).to eq 1
      end
    end

    describe "#forward_threshold_amount" do
      it "is transaction_fee * transaction_fee_threshold_multiplier" do
        config = described_class.new(config_path)
        config.transaction_fee = 22.0
        config.transaction_fee_threshold_multiplier = 2
        expected_value = 44.0
        expect(config.forward_threshold_amount).to eq(expected_value)
      end
    end

    describe "#blockchain_secrets=" do
      it "sets #blockchain_secrets" do
        config = described_class.new(config_path)
        config.blockchain_secrets = %w(a b)
        expect(config.blockchain_secrets).to eq %w(a b)
      end
    end

    describe "#blockchain" do
      it "returns the blockchain config" do
        config = described_class.new(config_path)
        expected_config = YAML.load_file(config_path).
          with_indifferent_access[:test][:blockchain]
        expect(config.blockchain).to eq expected_config
      end
    end

  end
end
