require "spec_helper"

describe PaymentJob, "#perform" do

  it "calls ProcessesPayments to do the work" do
    bit_wallet_master_account = build(:bit_wallet_account)
    allow(App).to receive(:bitcoin_master_account).
      and_return(bit_wallet_master_account)

    expect(ProcessesPayments).to receive(:for).
      with(App.bit_wallet, bit_wallet_master_account)
    described_class.new.perform
  end

end
