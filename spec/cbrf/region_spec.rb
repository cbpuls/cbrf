# frozen_string_literal: true

module Cbrf
  RSpec.describe Region, :vcr, with_regions: true do
    describe "#all" do
      it { expect(described_class.all).to all be_a Region }
    end

    describe "#branches" do
      it { expect(moscow.branches).to all be_a CreditOrganization::Office }
    end

    describe "#offices" do
      it { expect(moscow.offices).to all be_a CreditOrganization::Office }
    end

    describe "#credit_organizations" do
      it { expect(moscow.credit_organizations).to all be_a CreditOrganization }
    end
  end
end
