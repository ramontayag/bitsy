require "spec_helper"

module Bitsy
  describe GetLatestBlockIfPaymentDepots, ".execute" do

    let(:latest_block) { build(:blockchain_latest_block) }
    let(:resulting_ctx) do
      described_class.execute(payment_depots: payment_depots)
    end

    before do
      allow(Blockchain).to receive(:get_latest_block).
        and_return(latest_block)
    end

    describe "there are payment depots" do
      let(:payment_depots) { [1] }

      it "fetches the latest block" do
        expect(resulting_ctx.latest_block).to eq latest_block
      end
    end

    describe "there are no payment depots" do
      let(:payment_depots) { [] }

      it "does not fetch the latest block" do
        expect(resulting_ctx.latest_block).to be_nil
      end
    end

  end
end
