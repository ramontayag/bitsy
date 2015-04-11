require "spec_helper"

module Bitsy
  describe PaymentDepotSerializer do

    let(:payment_depot) do
      build_stubbed(:payment_depot, {
        address: "89s8x8",
        min_payment: 2.0,
        total_received_amount_cache: 19.0,
      })
    end
    let(:serializer) { described_class.new(payment_depot) }
    subject(:json) do
      JSON.parse(serializer.to_json).with_indifferent_access[:payment_depot]
    end

    before do
      expect(payment_depot).to receive(:min_payment_received?) { true }
      expect(payment_depot).to receive(:total_tax_sent).
        and_return("17.0")
      expect(payment_depot).to receive(:total_owner_sent).
        and_return("1.0")
      expect(payment_depot).to receive(:forwarding_transaction_fee).
        and_return("1.0")
    end

    its([:id]) { should eq payment_depot.id }
    its([:total_received_amount]) { should eq "19.0" }
    its([:min_payment_received]) { should be_true }
    its([:address]) { should eq "89s8x8" }
    its([:min_payment]) { should eq "2.0" }
    its([:total_tax_sent]) { should eq "17.0" }
    its([:total_owner_sent]) { should eq "1.0" }
    its([:forwarding_transaction_fee]) { should eq "1.0" }

  end
end
