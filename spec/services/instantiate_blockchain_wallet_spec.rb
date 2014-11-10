require "spec_helper"

module Bitsy
  describe InstantiateBlockchainWallet, ".execute" do

    let(:wallet) do
      build(:blockchain_wallet)
    end

    it "sets the blockchain wallet in the context" do
      config = Bitsy.config.blockchain
      expect(Blockchain::Wallet).to receive(:new).with(
        config[:identifier],
        config[:password],
        config[:second_password],
        config[:api_code],
      ).and_return(wallet)
      resulting_ctx = described_class.execute
      expect(resulting_ctx.wallet).to eq wallet
    end

  end
end
