# frozen_string_literal: true

module Cbrf
  RSpec.describe Credit, :vcr do
    describe "#version" do
      it { expect(described_class.version).to eq DateTime.xmlschema "2025-02-28T23:46:25.263" }
    end
  end
end
