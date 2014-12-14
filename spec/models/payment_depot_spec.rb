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

    describe ".for_manual_checking" do
      it "returns payment depots that haven't been paid for fully and checked_at is in the past" do
        expected_payment_depot = create(:payment_depot, {
          checked_at: 1.minute.ago,
          min_payment: 2,
          total_received_amount_cache: 3,
        })
        create(:payment_depot, min_payment: 2, total_received_amount_cache: 1)
        create(:payment_depot, checked_at: 1.minute.from_now)
        expect(described_class.for_manual_checking).
          to match_array([expected_payment_depot])
      end
    end

    describe ".received_at_least_minimum" do
      it "returns the payments depots that have received at least the minimum" do
        create(:payment_depot, {
          min_payment: 12.0,
          total_received_amount_cache: 11.0,
        })
        paid_payment_depot_1 = create(:payment_depot, {
          min_payment: 12.0,
          total_received_amount_cache: 12.0,
        })
        paid_payment_depot_2 = create(:payment_depot, {
          min_payment: 12.0,
          total_received_amount_cache: 13.0,
        })
        expect(described_class.received_at_least_minimum).
          to match_array([paid_payment_depot_1, paid_payment_depot_2])
      end
    end

    describe ".checked_at_is_past" do
      it "returns payment depots whose checked_at is in the past" do
        create(:payment_depot, checked_at: 5.minutes.from_now)
        payment_depot_2 = create(:payment_depot, checked_at: 2.minutes.ago)
        expect(PaymentDepot.checked_at_is_past).to match_array [payment_depot_2]
      end
    end

    describe "#reset_checked_at!" do
      before do
        Timecop.freeze
      end
      it "updates the checked_at to be current time plus the check_count**2 and ticks the check_count" do
        payment_depot = create(:payment_depot, {
          checked_at: 1.minute.ago,
          check_count: 4,
        })
        payment_depot.reset_checked_at!
        expected_checked_at = (4**2).seconds.from_now
        payment_depot.reload
        expect(payment_depot.checked_at.to_i).
          to eq expected_checked_at.to_i
        expect(payment_depot.check_count).to eq 5
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

    describe "#total_received_amount" do
      it "is the total_received_amount_cache value" do
        payment_depot = build_stubbed(:payment_depot, {
          total_received_amount_cache: 1.22,
        })
        expect(payment_depot.total_received_amount.to_f).to eq 1.22
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
