# frozen_string_literal: true

require "spec_helper"

RSpec.describe Cbrf::CreditOrganization, with_banks: true do
  describe "#last_update" do
    it "should return date" do
      expect(described_class.last_update).to be_a(DateTime)
    end
  end

  describe "#licenses" do
    subject { described_class.licenses }

    it { is_expected.to have_key(:Licens) }
  end

  describe "#bics" do
    subject { described_class.bics }

    it { is_expected.to have_key(:EnumBIC) }
  end

  describe "#infos" do
    subject { described_class.info(*[sber, alfa].map(&:internal_code)) }

    it { is_expected.to have_key(:CreditOrgInfo) }
  end

  describe "#info" do
    subject { described_class.new(sber.internal_code).info }

    it { is_expected.to have_key(:CreditOrgInfo) }
  end
end
