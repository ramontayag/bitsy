require 'spec_helper'

describe TransactionUpdater do

  describe '#update' do
    it 'should update the payment transaction' do
      payment_transaction = build_stubbed(:payment_transaction)
      bw_transaction = build(:bit_wallet_transaction,
                             confirmations: 3)
      payment_transaction.should_receive(:update_attributes).
        with(confirmations: 3)

      updater = described_class.new(payment_transaction, bw_transaction)
      updater.update
    end
  end

end
