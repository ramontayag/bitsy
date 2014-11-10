require 'spec_helper'

module Bitsy
  describe PaymentDepot do

    describe "validations" do
      subject { described_class.new }
      it { should validate_presence_of(:address) }
      it { should validate_presence_of(:balance_cache) }
      it do
        should ensure_inclusion_of(:initial_tax_rate).
          in_range(0.0..1.0).
          with_message('must be a value within 0.0 and 1.0')
      end
    end

    describe "after initialization" do
      context "there is no uuid" do
        it "creates a uuid" do
          uuid = UUIDTools::UUID.random_create
          expect(UUIDTools::UUID).to receive(:random_create) { uuid }
          payment_depot = PaymentDepot.new
          expect(payment_depot.uuid).to eq uuid.to_s
        end
      end

      context "there is a uuid" do
        it "does not overwrite the uuid" do
          payment_depot = PaymentDepot.new(uuid: "asdasd")
          expect(payment_depot.uuid).to eq "asdasd"
        end
      end
    end

    describe 'initial_tax_rate validity' do
      subject do
        build_stubbed(:payment_depot,
                      min_payment: 1,
                      initial_tax_rate: initial_tax_rate)
      end

      context 'initial_tax_rate is below 0' do
        let(:initial_tax_rate) { -1.5 }
        subject { should be_invalid }
      end

      context 'initial_owner_rate is within 0 and 1' do
        let(:initial_tax_rate) { 0.5 }
        subject { should be_valid }
      end

      context 'initial_owner_rate is above 1' do
        let(:initial_tax_rate) { 1.1 }
        subject { should be_invalid }
      end
    end

    describe '#balance_owner_amount' do
      it 'should return the part of the balance that should be sent to the owner address'
    end

    describe '#initial_owner_rate' do
      it 'should be the min_payment less than initial tax fee' do
        payment_depot = build_stubbed(:payment_depot,
                                      min_payment: 1,
                                      initial_tax_rate: 0.4)
        payment_depot.initial_owner_rate.should == 0.6
      end
    end

    describe '#total_received_amount' do
      it 'should return the total amount received' do
        tx1 = build_stubbed(:payment_transaction, amount: 1.2)
        tx2 = build_stubbed(:payment_transaction, amount: -1.1)
        build_stubbed(:payment_transaction, amount: 0.5)
        credits = [tx1, tx2]
        credits.stub(:sum).with(:amount).and_return(1.2+0.5)
        payment_depot = build_stubbed(:payment_depot)
        payment_depot.stub_chain(:transactions, :credits).
          and_return(credits)
        payment_depot.total_received_amount.should == 1.7
      end
    end

    describe '#total_tax_sent' do
      it 'should return the total amount sent to the tax address' do
        payment_depot = build_stubbed(:payment_depot)
        txs = double
        txs.stub(:sum).with(:amount).and_return(-3.7)
        payment_depot.stub(:tax_transactions).and_return(txs)
        payment_depot.total_tax_sent.should == 3.7
      end
    end

    describe '#total_owner_sent' do
      it 'should return the total amount sent to the owner address' do
        payment_depot = build_stubbed(:payment_depot)
        txs = double
        txs.stub(:sum).with(:amount).and_return(-5.5)
        payment_depot.stub(:owner_transactions).and_return(txs)
        payment_depot.total_owner_sent.should == 5.5
      end
    end

    describe "#bitcoin_account_name" do
      it "uses the uuid" do
        payment_depot = described_class.new(uuid: "asd123")
        expect(payment_depot.bitcoin_account_name).to eq "asd123"
      end
    end

  end
end
