require "spec_helper"

module Bitsy
  describe CheckPaymentDepotsTransactions, ".execute" do

    let(:latest_block) { build(:blockchain_latest_block) }
    let(:payment_depot_1) { build_stubbed(:payment_depot) }
    let(:payment_depot_2) { build_stubbed(:payment_depot) }
    let(:payment_depots) { [payment_depot_1, payment_depot_2] }

    before do
      expect(payment_depots).to receive(:find_each).and_yield(payment_depot_1).
        and_yield(payment_depot_2)
    end

    it "checks each payment depot due for manual checking" do
      payment_depots.each do |pd|
        expect(CheckPaymentDepotTransactions).to receive(:execute).with(
          latest_block: latest_block,
          payment_depot: pd,
        )
      end

      described_class.execute(
        payment_depots: payment_depots,
        latest_block: latest_block,
      )
    end

  end
end
