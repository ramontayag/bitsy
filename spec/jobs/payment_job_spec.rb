require "spec_helper"

describe PaymentJob, "#perform" do

  it "calls ProcessesPayments to do the work" do
    expect(ProcessesPayments).to receive(:for).with(App.bit_wallet)
    described_class.new.perform
  end

end
