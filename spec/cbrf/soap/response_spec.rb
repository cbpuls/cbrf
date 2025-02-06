# frozen_string_literal: true

RSpec.describe Cbrf::Soap::Response, :vcr do
  let(:xml) { File.read(File.expand_path("../../fixtures/info.xml", __dir__)) }
  subject { described_class.new(:CreditInfoByIntCode, xml) }

  describe "#to_h" do
    it { expect(subject.to_h).to have_key(:"soap:Envelope") }
  end

  describe "#to_hash" do
    it do expect(subject.to_h).to have_key(:"soap:Envelope") end
  end

  describe "#schema" do
    it { expect(subject.schema[0]).to have_key(:id) }
  end
  describe "#diff" do
    it { expect(subject.diff).to have_key(:CreditOrgInfo) }
  end
end
