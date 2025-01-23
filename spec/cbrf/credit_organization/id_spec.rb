# frozen_string_literal: true

RSpec.describe Cbrf::CreditOrganization::Id, with_banks: true do
  # before { stub_request(:get, API.uri).to_return(status: 401, body: fixture("401.json")) }
  let(:code) { "0" }
  let(:id) { described_class.new(code) }

  describe "#bic" do
    it { expect(id.bic).to eq(code) }
    it { expect(id.internal_code).to eq("-1") }
    it { expect(id.registry_number).to eq("-1") }
  end

  describe "#internal_code" do
    let(:code) { "12345678" }

    it { expect(id.internal_code).to eq(code) }

    context "from bic" do
      let(:code) { sber[:bic] }

      it { expect(id.internal_code).to eq(sber[:internal_code]) }
    end

    context "from registry_number" do
      let(:code) { sber[:registry_number] }

      it { expect(id.internal_code).to eq(sber[:internal_code]) }
    end
  end

  describe "#registry_number" do
    let(:code) { "1234" }

    it { expect(id.registry_number).to eq(code) }

    context "from bic" do
      let(:code) { sber[:bic] }

      it { expect(id.registry_number).to eq(sber[:registry_number]) }
    end

    context "from registry_number" do
      let(:code) { sber[:internal_code] }

      it { expect(id.registry_number).to eq(sber[:registry_number]) }
    end
  end
end
