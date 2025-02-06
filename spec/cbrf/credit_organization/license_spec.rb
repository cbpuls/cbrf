# frozen_string_literal: true

module Cbrf
  RSpec.describe CreditOrganization::License, :vcr do
    describe "#all" do
      it { expect(described_class.all).to all be_a CreditOrganization::License }
    end
  end
end
