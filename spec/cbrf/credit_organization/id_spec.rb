# frozen_string_literal: true

RSpec.describe Cbrf::CreditOrganization::Id, with_banks: true do
  # before { stub_request(:get, API.uri).to_return(status: 401, body: fixture("401.json")) }
  subject { Cbrf::Conversions::Id(code) }

  let(:code) { "0" }

  describe "#bic" do
    it { expect(subject.bic).to eq code }
  end

  describe "#internal_code" do
    it { expect(subject.internal_code).to eq(-1) }

    context "received from bic" do
      let(:code) { sber.bic }

      it { expect(subject.internal_code).to eq sber.internal_code }
    end

    context "received from registry_number" do
      let(:code) { sber.registry_number }

      it { expect(subject.registry_number).to eq sber.registry_number }
      it { expect(subject.internal_code).to eq sber.internal_code }
    end
  end

  describe "#registry_number" do
    it { expect(subject.registry_number).to eq(-1) }

    context "received from bic" do
      let(:code) { sber.bic }

      it { expect(subject.registry_number).to eq sber.registry_number }
    end

    context "received from internal_code" do
      let(:code) { sber.internal_code }

      it { expect(subject.registry_number).to eq sber.registry_number }
    end
  end

  describe "#bics" do
    it { expect(described_class.bics).to be_an Array }
  end

  describe "#all" do
    it { expect(described_class.all).to all be_a(Cbrf::CreditOrganization::Id) }
  end
end
