# frozen_string_literal: true

RSpec.describe Cbrf::Region, with_regions: true do
  describe "#all" do
    it { expect(described_class.all).to all(be_a(Cbrf::Region)) }
  end

  describe "#offices" do
    it { expect(moscow.offices).to eq 1 }
  end

  describe "#credit_organizations" do
    it { expect(moscow.credit_organizations).to all(be_a(Cbrf::CreditOrganization)) }

    # context "count in moscow" do
    # it { expect(moscow.credit_organizations.dig(:CreditOrg, :EnumCredits).size).to eq 1371 }
    # end
  end
end
