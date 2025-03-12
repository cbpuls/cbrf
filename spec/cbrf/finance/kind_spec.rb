# frozen_string_literal: true

RSpec.describe Cbrf::Finance::Kind, :vcr do
  describe "#all" do
    it { expect(described_class.all).to all be_a Cbrf::Finance::Kind }
  end
end
