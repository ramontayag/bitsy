require "spec_helper"

module Bitsy
  describe ComputeAmountForSplitting, ".execute" do

    before do
      create(:payment_transaction, amount: 0.2)
      create(:payment_transaction, amount: 1.2)
    end
    let(:payment_transactions) { PaymentTransaction.all }
    let(:transaction_fee) { 0.0001 }

    it "sets the amount that will be left after subtracting the transaction fee, and the total amount" do
      resulting_ctx = described_class.execute(
        transaction_fee: transaction_fee,
        payment_transactions: payment_transactions,
      )
      expect(resulting_ctx.amount_for_splitting).to eq 1.3999
      expect(resulting_ctx.total_amount).to eq 1.4
    end

  end
end
