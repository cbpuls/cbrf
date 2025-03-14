# frozen_string_literal: true

module Cbrf::Finance
  RSpec.describe Organization, :vcr do
    describe "#all" do
      it { expect(described_class.all).to eq "" }
    end
    describe "#find" do
      context "by internal code" do
      end
      context "by inn" do
      end
      context "by ogrn" do
        # it { expect(described_class.find("1027700132195")).to eq "" }
      end
    end
  end
end
