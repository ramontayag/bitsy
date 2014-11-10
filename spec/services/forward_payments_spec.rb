require "spec_helper"

# ForwardPayments attemps to save on Bitcoin transaction fees. Since
# application is meant to accept micro payments, sending a fee (0.0001) every
# time we receive a payment would be costly.
#
# If all the transactions meant to forwarded are on or past the threshold for
# forwarding, the master account will create one transaction that sends it to
# the tax address, and the owner addresses. This allows the system to spend only
# one fee everytime we reach the threshold.

module Bitsy
  describe ForwardPayments, ".execute" do
    let(:actions) do
      [
        InstantiateBlockchainWallet,
        BuildSendManyHash,
        SendPayments,
        AssociatesTransactions
      ]
    end

    let(:payment_txs) do
      [
        build_stubbed(:payment_transaction),
        build_stubbed(:payment_transaction)
      ]
    end

    let(:ctx) do
      {
        payment_transactions: payment_txs,
      }
    end

    before do
      allow(PaymentTransaction).to receive(:for_forwarding) { payment_txs }
    end

    context "transactions on or past the threshold" do
      before do
        allow(payment_txs).to receive(:sum).with(:amount).
          and_return(Bitsy.config.forward_threshold_amount)
      end

      it "performs the actions in order" do
        actions.each do |action|
          expect(action).to receive(:execute).with(ctx) { ctx }
        end

        described_class.execute
      end
    end

    context "transactions are not past the threshold" do
      before do
        allow(payment_txs).to receive(:sum).with(:amount).
          and_return(Bitsy.config.forward_threshold_amount - 0.1)
      end

      it "does nothing" do
        actions.each do |action|
          expect(action).to_not receive(:execute)
        end

        described_class.execute
      end
    end
  end
end
