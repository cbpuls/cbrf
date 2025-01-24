# frozen_string_literal: true

require "spec_helper"

RSpec.describe Cbrf::CreditOrganization, with_banks: true, with_regions: true do
  describe "#last_update" do
  end

  describe "#licenses" do
    subject { described_class.licenses }

    # it { is_expected.to have_key(:Licens) }
  end

  describe "#bics" do
    subject { described_class.bics }

    # it { is_expected.to have_key(:EnumBIC) }
  end

  describe "#infos" do
    subject { described_class.info(*[sber, alfa].map(&:internal_code)) }

    # it { is_expected.to have_key(:CreditOrgInfo) }
  end

  describe "#info" do
    subject { described_class.new(sber.internal_code).info }

    # it { is_expected.to have_key(:CreditOrgInfo) }
  end

  describe "#note" do
    subject { described_class.new(sber.registry_number).note }

    # it { is_expected.to have_key(:CredorgInfo) }
  end

  describe "#forms" do
    subject { described_class.new(sber.registry_number).form(form).on(date) }
  end

  let(:id) { sber.internal_code }
  subject { described_class.new(id) }

  describe "#fbu" do
    let(:id) { alfa.internal_code }
    # pending "find bank with FBU"
    # it { expect(subject.fbu).to eq 123 }
  end

  describe "#offices" do
    it { expect(subject.offices).to have_key(:CoOffices) }

    context "size" do
      it { expect(subject.offices.dig(:CoOffices, :Offices).size).to eq 86 }
    end
  end

  describe "#offices_in" do
    it { expect(subject.offices_in(moscow)).to have_key(:CoOffices) }
    context "moscow size" do
      it { expect(subject.offices_in(moscow).dig(:CoOffices, :Offices).size).to eq 44 }
    end
  end

  describe "#periods" do
    it { expect(subject.periods).to have_key(:Docs) }

    context "count" do
      it { expect(subject.periods[:Docs].size).to eq 10 }
    end
  end

  describe "#cards" do
    # it { expect(subject.cards).to eq 1 }
  end

  describe "#agencies" do
    it { expect(subject.agencies).to have_key(:Agency) }
  end

  describe "#bankrupt" do
    it { expect(subject.bankrupt).to be_nil }
  end

  describe "#sites" do
    it { expect(subject.sites).to have_key(:CredorgSites) }
  end

  describe "#search branches" do
    # it { expect(subject.search("С")).to eq 1 }
  end

  describe "#last_update" do
    it { expect(described_class.last_update.year).to eq 2025 }
  end

  describe "#search" do
    it { expect(described_class.search("СБЕР")).to have_key(:CreditOrg) }
  end

  describe "#regions" do
    it { expect(described_class.regions).to have_key(:RegionsEnum) }

    context "count" do
      it { expect(described_class.regions.dig(:RegionsEnum, :RGID).size).to eq 91 }
    end
  end
end
