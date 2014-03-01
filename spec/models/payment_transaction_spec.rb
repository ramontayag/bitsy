require "spec_helper"

describe PaymentTransaction do

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

  describe ".matching_bit_wallet_transaction" do
    it "returns the payment transactions that match the bit wallet transaction" do
      occurred_at = Time.new(2013, 1, 2, 3, 4, 5)
      received_at = Time.new(2013, 1, 2, 3, 4, 6)

      bit_wallet_transaction = double(
        id: "932hx9",
        address_str: "38x883mmz94m32mxcz",
        amount: 2.0,
        occurred_at: occurred_at,
        received_at: received_at
      )

      payment_transactions = described_class.
        matching_bit_wallet_transaction(bit_wallet_transaction)

      expected_where_values = [
        %Q("payment_transactions"."transaction_id" = '932hx9'),
        %Q("payment_transactions"."receiving_address" = '38x883mmz94m32mxcz'),
        %Q("payment_transactions"."amount" = 2.0),
        %Q("payment_transactions"."occurred_at" = '2013-01-02 03:04:05.000000'),
        %Q("payment_transactions"."received_at" = '2013-01-02 03:04:06.000000')
      ]

      resulting_where_sql = payment_transactions.where_values.map(&:to_sql)

      expect(resulting_where_sql).to eq(expected_where_values)
    end
  end

end
