require "spec_helper"

module Bitsy
  module Updating
    describe SelectTransactions, ".execute" do

      let(:tx1) { build_stubbed(:payment_transaction) }
      let(:tx2) { build_stubbed(:payment_transaction) }
      let(:txs) { [tx1, tx2] }
      before do
        allow(PaymentTransaction).to receive(:not_forwarded).and_return(txs)
      end

      it "selects transactions that have not been forwarded" do
        expect(described_class.execute.payment_transactions).to eq txs
      end

    end
  end
end
