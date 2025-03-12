# frozen_string_literal: true

RSpec.describe Cbrf::Finance, :vcr do
  describe "#version" do
    it { expect(described_class.version).to eq DateTime.xmlschema "2025-03-11T00:00:00" }
  end
end
