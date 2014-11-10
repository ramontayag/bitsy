require "spec_helper"

module Bitsy
  module Updating
    describe GetLatestBlock, ".execute" do

      let(:latest_block) { build(:blockchain_latest_block) }

      it "fetches the latest block" do
        expect(Blockchain).to receive(:get_latest_block).and_return(latest_block)
        resulting_ctx = described_class.execute
        expect(resulting_ctx.latest_block).to eq latest_block
      end

    end
  end
end
