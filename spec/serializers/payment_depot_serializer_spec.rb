require "spec_helper"

describe PaymentDepotSerializer do

  let(:payment_depot) do
    build_stubbed(:payment_depot, address: "89s8x8")
  end
  let(:serializer) { described_class.new(payment_depot) }
  subject(:json) do
    JSON.parse(serializer.to_json).with_indifferent_access[:payment_depot]
  end

  before do
    expect(payment_depot).to receive(:total_received_amount) { 19.0 }
    expect(payment_depot).to receive(:min_payment_received?) { true }
  end

  its([:id]) { should eq payment_depot.id }
  its([:total_received_amount]) { should eq 19.0 }
  its([:min_payment_received]) { should be_true }
  its([:address]) { should eq "89s8x8" }

end
