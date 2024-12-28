# frozen_string_literal: true

RSpec.describe Cbrf::Soap::Response do
  let(:xml) { File.read(File.expand_path("../../fixtures/info.xml", __dir__)) }
  subject { described_class.new(:CreditInfoByIntCode, xml) }

  describe "#to_hash" do
    it do
      expect(subject.to_h).to have_key(:CreditOrgInfo)
    end
  end
end
