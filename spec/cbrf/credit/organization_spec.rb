# frozen_string_literal: true

module Cbrf
  module Credit
    RSpec.describe Organization, :vcr, with_banks: true, with_regions: true do
      describe "#find" do
        it "should return info sberbank" do
          expect(described_class.find(sber.internal_code).keys).to eq %i[CO LIC]
        end

        it "should return info sberbank and alfabank together" do
          expect(described_class.find(sber.internal_code, alfa.internal_code).keys).to eq %i[CO LIC]
        end
      end
    end
  end
end
