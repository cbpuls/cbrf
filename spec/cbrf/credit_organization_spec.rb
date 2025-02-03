# frozen_string_literal: true

require "spec_helper"

module Cbrf
  RSpec.describe CreditOrganization, with_banks: true, with_regions: true do
    let(:co) { sber }
    subject { described_class.new(id: co) }

    describe "cards" do
      it { expect(subject.cards).to be_nil }
    end

    describe "#agencies" do
      it { expect(subject.agencies).not_to be_empty }
    end

    describe "balance" do
      context "1998" do
        it { expect(subject.balance(1998)).not_to be_empty }
      end
    end

    describe "bankrupt" do
      it { expect(subject.bankrupt).to be_nil }
    end

    describe "#fbu" do
      it { expect(subject.fbu).to be_nil }
    end

    describe "#offices" do
      it { expect(subject.offices).not_to be_empty }
    end

    describe "#periods" do
      it { expect(subject.periods).not_to be_empty }
    end

    describe "sites" do
      it { expect(subject.sites).not_to be_empty }
    end

    describe "#find" do
      it { expect(described_class.find(sber.registry_number)).to be_a described_class }
    end

    describe "#full" do
      it "should return info sberbank" do
        expect(described_class.full(sber.internal_code).keys).to eq %i[CO LIC]
      end

      it "should return info sberbank and alfabank together" do
        expect(described_class.full(sber.internal_code, alfa.internal_code).keys).to eq %i[CO LIC]
      end
    end

    describe "#last_update" do
      it { expect(described_class.last_update.year).to eq 2025 }
    end

    describe "#sites" do
      it { expect(described_class.sites(name: "СБЕР", url: "")).not_to be_empty }
    end

    describe "#search" do
      it { expect(described_class.search("СБЕР")).to all be_a CreditOrganization }
    end

    describe "#search_by" do
      it { expect(described_class.search_by(name: "СБЕР", region: moscow.id)).to all be_a CreditOrganization }
    end

    describe "#regions" do
      it { expect(described_class.regions).to all be_a Region }
    end
  end
end
