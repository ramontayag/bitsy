require "spec_helper"

module Bitsy
  describe PaymentDepotFilterer do

    it "filters by id" do
      filterer = described_class.chain(id: [2, 3])
      expect(filterer.to_sql).to eq PaymentDepot.where(id: [2, 3]).to_sql
    end

  end
end
