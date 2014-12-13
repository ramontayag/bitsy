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

    [
      :transaction_fee,
      :transaction_fee_threshold_multiplier,
      :safe_confirmation_threshold,
      :blockchain_secrets,
      :debug,
      :send_many_log_path,
      :check_limit,
    ].each do |attr|
      describe "##{attr}=" do
        it "sets ##{attr}" do
          config = described_class.new(config_path)
          config.send("#{attr}=", "value for #{attr}")
          expect(config.send(attr)).to eq "value for #{attr}"
        end
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
