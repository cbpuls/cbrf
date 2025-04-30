# frozen_string_literal: true

module Cbrf
  RSpec.describe Credit, :vcr do
    # describe "#test" do
    #   it { expect(described_class.test).to eq 1 }
    # end

    describe "#version" do
      it { expect(described_class.version).to eq "2025-04-21T23:45:50.58" }
    end

    describe "#bics" do
      it { expect(Credit.bics).not_to be_empty }
    end

    describe "#regions" do
      it { expect(Credit.regions).not_to be_empty }
    end
  end
end
