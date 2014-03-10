require "spec_helper"

describe SendsPayments, ".execute" do

  let(:bit_wallet_master_account) { build(:bit_wallet_account) }
  let(:send_many_hash) { {does: "not", matter: "ok" } }

  it "initiates a payment using the :send_many_hash from the master account" do
    expect(bit_wallet_master_account).
      to receive(:send_many).with(send_many_hash).
      and_return("txid")

    ctx = { bit_wallet_master_account: bit_wallet_master_account,
            send_many_hash: send_many_hash }

    resulting_ctx = described_class.execute(ctx)

    expect(resulting_ctx[:forwarding_transaction_id]).to eq("txid")
  end

end
