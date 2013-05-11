require 'spec_helper'

describe PaymentForwarder do

  describe '#forward' do
    context 'default account balance < forward threshold' do
      it 'should not send out coins' do
        default_account = build(:bit_wallet_account)
        default_account.stub(balance: App.forward_threshold)
        App.stub(bitcoin_master_account: default_account)

        payment_transactions = double
        payment_transactions.stub(:sum).with(:amount).
          and_return(App.forward_threshold - 0.00001)
        PaymentTransaction.stub_chain(:safely_confirmed, :not_forwarded).
          and_return(payment_transactions)

        forwarder = described_class.new
        default_account.should_not_receive(:send_many)
        forwarder.forward
      end
    end

    context 'default account balance >= forward threshold' do
      it 'should send out coins to the concerned addresses' do
        default_account = build(:bit_wallet_account)
        default_account.stub(balance: App.forward_threshold)
        App.stub(bitcoin_master_account: default_account)

        payment_transaction_1 = build_stubbed(:payment_transaction,
                                              amount: 0.3)
        payment_transaction_2 = build_stubbed(:payment_transaction,
                                              amount: 1.1)
        payment_transactions = [payment_transaction_1, payment_transaction_2]
        payment_transactions.stub(:sum).with(:amount).
          and_return(App.forward_threshold + 0.1)

        PaymentTransaction.stub_chain(:safely_confirmed, :not_forwarded).
          and_return(payment_transactions)

        PaymentSendManyHashBuilder.stub(:build).with(payment_transaction_1).
          and_return(payment_1: 21.2)
        PaymentSendManyHashBuilder.stub(:build).with(payment_transaction_2).
          and_return(payment_2: 12.3)

        send_many_args = {payment_1: 21.2,
                          payment_2: 12.3}
        default_account.should_receive(:send_many).
          with(hash_including(send_many_args))

        forwarder = described_class.new
        forwarder.forward
      end
    end
  end

end
