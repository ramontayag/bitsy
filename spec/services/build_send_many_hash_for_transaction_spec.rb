require "spec_helper"

module Bitsy
  describe BuildSendManyHashForTransaction, ".execute" do

    let(:payment_depot) do
      build_stubbed(:payment_depot, {
        owner_address: "owner_address",
        tax_address: "tax_address",
      })
    end
    let(:payment_transaction) do
      build_stubbed(:payment_transaction, payment_depot: payment_depot)
    end
    let(:amount_for_splitting) { 3.2 - 0.0001 }
    let(:total_amount) { 10.0 }

    before do
      expect(payment_transaction).to receive(:forward_tax_fee).
        and_return(0.2)
      expect(payment_transaction).to receive(:owner_fee).
        and_return(3.0)
    end

    it "creates the hash for a single transaction" do
      tax_share_of_total = 0.2 / total_amount
      expected_tax_amount = tax_share_of_total *
        100_000_000 *
        amount_for_splitting
      expected_tax_amount = expected_tax_amount.to_i

      owner_share_of_total = 3.0 / total_amount
      expected_owner_amount = owner_share_of_total *
        100_000_000 *
        amount_for_splitting
      expected_owner_amount = expected_owner_amount.to_i

      expected_hash = {
        "tax_address" => expected_tax_amount,
        "owner_address" => expected_owner_amount,
      }

      resulting_ctx = described_class.execute(
        amount_for_splitting: amount_for_splitting,
        payment_transaction: payment_transaction,
        total_amount: total_amount,
      )

      expect(resulting_ctx.transaction_send_many_hash).to eq expected_hash
    end

  end
end
