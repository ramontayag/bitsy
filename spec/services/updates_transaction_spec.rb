require "spec_helper"

describe UpdatesTransaction, ".execute" do

  it "updates the payment tx with the details of the bit wallet tx" do
    bit_wallet_tx = build(:bit_wallet_transaction, confirmations: 3)
    payment_tx = build_stubbed(:payment_transaction)

    expect(payment_tx).to receive(:update_attributes).with(confirmations: 3)

    described_class.execute(bit_wallet_transaction: bit_wallet_tx,
                            payment_transaction: payment_tx)
  end

end
