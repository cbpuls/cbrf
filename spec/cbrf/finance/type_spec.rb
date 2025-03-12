# frozen_string_literal: true

RSpec.describe Cbrf::Finance::Type, :vcr do
  describe "#all" do
    it { expect(described_class.all).to all be_a described_class }
  end
end
