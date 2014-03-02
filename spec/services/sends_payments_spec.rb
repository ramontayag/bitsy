require "spec_helper"

describe SendsPayments, ".execute" do

  let(:bit_wallet_master_account) { build(:bit_wallet_account) }
  let(:send_many_hash) { {does: "not", matter: "ok" } }

  it "initiates a payment using the :send_many_hash from the master account" do
    expect(bit_wallet_master_account).
      to receive(:send_many).with(send_many_hash)

    ctx = { bit_wallet_master_account: bit_wallet_master_account,
            send_many_hash: send_many_hash }

    described_class.execute(ctx)
  end

end
