require 'spec_helper'

# Sample transactions
# {
#   "result":
#   [
#     {
#       "account": "1",
#       "address": "mkwWW2pnqFkDfH5esHxXBNARTN7GnUDpsv",
#       "category": "receive",
#       "amount": 7.00000000,
#       "confirmations": 0,
#       "txid": "7f689da81bd755940cb31ca403fb3083a02a93fe1e918827ac2de2326142a911",
#       "time": 1362652279,
#       "timereceived": 1362652279
#     },
#     {
#       "account": "",
#       "address": "mkwWW2pnqFkDfH5esHxXBNARTN7GnUDpsv",
#       "category": "send",
#       "amount": -7.00000000,
#       "fee": 0.00000000,
#       "confirmations": 0,
#       "txid": "7f689da81bd755940cb31ca403fb3083a02a93fe1e918827ac2de2326142a911",
#       "time": 1362652279,
#       "timereceived": 1362652279
#     }
#   ],
#     "error": null,
#     "id": "jsonrpc"
# }


describe TransactionsPoller do

  describe '#sync' do
    context 'when the transaction has not been syncd before' do
      it 'should create the transaction in the db' do
        payment_depot = build_stubbed(:payment_depot)
        PaymentDepot.stub(:find).with(payment_depot.id).and_return(payment_depot)
        bit_wallet_account = double(name: payment_depot.id.to_s)

        occurred_at = 2.minutes.ago
        recieved_at = 1.minute.ago

        bit_wallet_transaction = double(account: bit_wallet_account,
                                        amount: 214.0,
                                        address_str: '1234asdf',
                                        category: 'received',
                                        confirmations: 0,
                                        id: 'txid123',
                                        occurred_at: occurred_at,
                                        recieved_at: recieved_at)

        PaymentTransaction.stub(:exists?).
          with(transaction_id: 'txid123').
          and_return(false)

        bit_wallet_transactions = [bit_wallet_transaction]

        syncer = described_class.new
        args = {payment_depot: payment_depot,
                amount: 214.0,
                confirmations: 0,
                transaction_id: 'txid123',
                receiving_address: '1234asdf',
                category: 'received',
                occurred_at: occurred_at,
                recieved_at: recieved_at}

        PaymentTransaction.should_receive(:create).with(hash_including(args))
        syncer.stub(:transactions).and_return(bit_wallet_transactions)
        syncer.sync
      end
    end

    context 'when the transaction has been syncd before' do
      it 'should not create the transaction' do
        payment_depot = build_stubbed(:payment_depot)
        PaymentDepot.stub(:find).with(payment_depot.id).and_return(payment_depot)
        bit_wallet_account = double(name: payment_depot.id.to_s)

        occurred_at = 2.minutes.ago
        recieved_at = 1.minute.ago

        bit_wallet_transaction = double(account: bit_wallet_account,
                                        amount: 214.0,
                                        address_str: '1234asdf',
                                        category: 'received',
                                        confirmations: 0,
                                        id: 'txid123',
                                        occurred_at: occurred_at,
                                        recieved_at: recieved_at)

        bit_wallet_transactions = [bit_wallet_transaction]

        payment_transaction = build_stubbed(:payment_transaction)
        PaymentTransaction.stub(:exists?).
          with(transaction_id: 'txid123').
          and_return(true)

        PaymentTransaction.should_not_receive(:create)
        syncer = described_class.new
        syncer.stub(:transactions).and_return(bit_wallet_transactions)
        syncer.sync
      end
    end
  end

end
