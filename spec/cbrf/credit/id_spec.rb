# frozen_string_literal: true

RSpec.describe Cbrf::Credit::Id, :vcr, with_banks: true do
  let(:code) { "0" }
  subject { described_class.new(code) }

  describe "#bic" do
    it { expect(subject.bic).to eq code }
  end

  describe "#internal_code" do
    it { expect(subject.internal_code).to eq(-1) }

    context "received from bic" do
      let(:code) { sber.bic }

      it { expect(subject.internal_code).to eq sber.internal_code }
    end

    context "received from registry_no" do
      let(:code) { sber.registry_no }

      it { expect(subject.registry_no).to eq sber.registry_no }
      it { expect(subject.internal_code).to eq sber.internal_code }
    end
  end

  describe "#registry_no" do
    it { expect(subject.registry_no).to eq(-1) }

    context "received from bic" do
      let(:code) { sber.bic }

      it { expect(subject.registry_no).to eq sber.registry_no }
    end

    context "received from internal_code" do
      let(:code) { sber.internal_code }

      it { expect(subject.registry_no).to eq sber.registry_no }
    end
  end

  describe "#bics" do
    it { expect(described_class.bics).to all be_a Hash }
  end

  describe "#all" do
    it { expect(described_class.all).to all be_a(Cbrf::Credit::Id) }
  end
end
