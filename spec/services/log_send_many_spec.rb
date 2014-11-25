require "spec_helper"

module Bitsy
  describe LogSendMany, ".execute" do

    let(:file_path) { Bitsy.config.send_many_log_path }

    it "logs what it will send out" do
      described_class.execute(
        payment_transactions: [],
        computed_transaction_fee: 0.0,
        send_many_hash: {some: "hash"},
      )

      expect(File).to exist(file_path)
    end

    after do
      FileUtils.rm(file_path)
    end

  end
end
