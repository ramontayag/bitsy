require "spec_helper"

module Bitsy
  describe PaymentTransaction do

    describe "after creation" do
      let(:payment_depot) { create(:payment_depot) }

      it "updates its payment depot's total_received_amount_cache" do
        create(:payment_transaction, {
          payment_depot: payment_depot,
          amount: 0.5,
          payment_type: "receive",
        })
        expect(payment_depot.reload.total_received_amount_cache).to eq 0.5
        create(:payment_transaction, {
          payment_depot: payment_depot,
          amount: 1.5,
          payment_type: "receive",
        })
        expect(payment_depot.reload.total_received_amount_cache).to eq 2.0
      end

      context "payment_type is not receive" do
        it "does not update the payment depot's total_received_amount_cache" do
          create(:payment_transaction, {
            payment_depot: payment_depot,
            amount: 0.5,
            payment_type: "send",
          })
          expect(payment_depot.reload.total_received_amount_cache).to be_zero
        end
      end
    end

    describe ".for_forwarding" do
      it "returns the safe confirmed, not forwarded, and received transactions" do
        expected_sql = described_class.
          safely_confirmed.
          not_forwarded.
          received.to_sql

        resulting_sql = described_class.for_forwarding.to_sql

        expect(resulting_sql).to eq(expected_sql)
      end
    end

    describe ".credits" do
      it "returns the received payments" do
        expected_where_values = [
          %Q("#{described_class.table_name}"."payment_type" = 'receive')
        ]
        resulting_where_values =
          described_class.credits.where_values.map(&:to_sql)
        expect(resulting_where_values).to eq(expected_where_values)
      end
    end

    describe ".debits" do
      it "returns the payments sent out (forwarding transactions)" do
        tx_1 = create(:payment_transaction, forwarding_transaction_id: 3)
        tx_2 = create(:payment_transaction, forwarding_transaction_id: nil)

        expect(described_class.debits.to_a).to match_array([tx_1])
      end
    end

    describe "#payment_depot_total_received_amount" do
      it "is the sum of received transactions of the payment depot" do
        payment_depot = build_stubbed(:payment_depot)
        allow(payment_depot).to receive(:total_received_amount) { 1.5 }
        payment_tx = build_stubbed(:payment_transaction,
                                   payment_depot: payment_depot)
        expect(payment_tx.payment_depot_total_received_amount).to eq(1.5)
      end
    end

    describe "#forward_tax_fee" do
      it "is the tax fee imposed on the payment for this particular transaction" do
        payment_depot = build_stubbed(:payment_depot)
        payment_tx = build_stubbed(:payment_transaction,
                                   payment_depot: payment_depot,
                                   amount: 0.5)
        allow(payment_tx).to receive(:payment_depot_min_payment) { 1.0 }
        allow(payment_tx).to receive(:payment_depot_total_received_amount) { 2.0 }
        allow(payment_tx).to receive(:payment_depot_initial_tax_rate) { 3.0 }
        allow(payment_tx).to receive(:payment_depot_added_tax_rate) { 4.0 }
        expect(ForwardTaxCalculator).to receive(:calculate).with(
          0.5,
          1.0,
          2.0,
          3.0,
          4.0
        ).and_return(4.5)

        expect(payment_tx.forward_tax_fee).to eq(4.5)
      end
    end

  end
end
