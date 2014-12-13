module Bitsy
  class Config

    attr_accessor(
      :transaction_fee,
      :transaction_fee_threshold_multiplier,
      :safe_confirmation_threshold,
      :blockchain_secrets,
      :blockchain,
      :debug,
      :send_many_log_path,
      :check_limit,
    )

    def initialize(file_path)
      @config ||= YAML.load_file(file_path).
        with_indifferent_access.
        fetch(Rails.env.to_s)

      @config.each do |k, v|
        self.class.send :define_method, k do
          @config.fetch(k)
        end
      end
    end

    def forward_threshold_amount
      transaction_fee * transaction_fee_threshold_multiplier
    end

  end
end
