# frozen_string_literal: true

module Cbrf
  RSpec.describe Cbrf::CreditOrganization::Form, :vcr, with_banks: true do
    let(:type) { self.class.description }
    let(:registry_number) { sber.registry_number }
    let(:date) { Date.new 2024, 1, 1 }
    let(:par) { nil }
    let(:from) { date }
    let(:to) { Date.new 2024, 12, 1 }
    let(:indicator) { nil }

    subject { described_class.new(type) << registry_number }

    let(:data) { subject.on date, par }
    let(:full) { subject.full_on date, par }
    let(:dates) { subject.dates }
    let(:max) { subject.max }
    let(:indicators) { subject.indicators }
    let(:by_indicator) { subject.by(indicator, from:, to:) }

    describe "101" do
      let(:indicator) { 106 }

      it "should return data on 2024-01-01" do
        expect(data).not_to be_empty
      end

      it "should return dates" do
        expect(dates).not_to be_empty
      end

      it "should return max date" do
        expect(max).to be_a DateTime
      end

      it "should return indicators" do
        expect(indicators).to all be_a CreditOrganization::Indicator
      end

      it "should return data by indicator from 2024-01-01 to 2024-01-01" do
        expect(by_indicator).not_to be_empty
      end

      xit "should return multy by indicator from 2024-01-01 to 2024-01-01" do
        expect(subject.by(indicator, from:, to:, ids: [sber.registry_number, alfa.registry_number])).to eq 1
      end
    end

    describe "102" do
      let(:indicator) { 11_000 }
      # let(:date) { "2024-01-01T00:00:00" }

      it "should return data on 2024-01-01" do
        expect(data).to have_key(:F102FNew)
      end

      it "should return dates" do
        expect(dates).not_to be_empty
      end

      it "should return max date" do
        expect(max).to be_a DateTime
      end

      it "should return indicators" do
        expect(indicators).to all be_a Cbrf::CreditOrganization::Indicator
      end

      it "should return data by indicator from 2024-01-01 to 2024-01-01" do
        expect(by_indicator).not_to be_empty
      end

      xit "should return multy by indicators from 2024-01-01 to 2024-01-01" do
        expect(subject.by(indicator, from:, to:, ids: [sber.registry_number, alfa.registry_number])).to eq 1
      end
    end

    describe "123" do
      it "should return data on 2024-01-01" do
        expect(data).to have_key(:F123b)
      end

      it "should return full data on 2024-01-01" do
        expect(full).to have_key(:F123DATA)
      end

      it "should return dates" do
        expect(dates).not_to be_empty
      end

      it "should return max date" do
        expect(max).to be_a DateTime
      end
    end

    describe "134" do
      let(:date) { Date.new 2015, 1, 1 }
      it "should return data on 2015-01-01" do
        expect(data).to have_key(:F134b)
      end

      it "should return dates" do
        expect(subject.dates).not_to be_empty
      end

      it "should return max date" do
        expect(max).to be_a DateTime
      end
    end

    describe "135" do
      it "should return data on 2024-01-01" do
        expect(data).to have_key(:F135DATA)
      end

      it "should return meta data on 2024-01-01" do
        expect(subject.meta(Date.new(2024, 1, 1))).to have_key(:F135Meta)
      end

      it "should return dates" do
        expect(dates).not_to be_empty
      end

      it "should return max date" do
        expect(max).to be_a DateTime
      end
    end

    describe "802" do
      xit "should return data on 2024-01-01" do
        expect(data).to eq 1
      end
    end

    describe "803" do
      xit "should return nil on 2024-01-01" do
        expect(data).to have_key(:F)
      end
    end

    describe "805" do
      let(:date) { Date.new 2024, 7, 1 }
      let(:par) { 1 }

      xit "should return data on 2024-01-01" do
        expect(data).to have_key(:F805)
      end
    end

    describe "806" do
      it "should return data on 2024-01-01" do
        expect(data).to have_key(:NewDataSet)
      end
    end

    describe "807" do
      let(:par) { 1 }
      it "should return data on 2024-01-01" do
        expect(data).to have_key(:NewDataSet)
      end
    end

    describe "808" do
      let(:par) { 1 }
      it "should return data on 2024-01-01" do
        expect(data).to have_key(:NewDataSet)
      end
      it "should return data parent organization on 2024-01-01" do
        expect(full).to have_key(:NewDataSet)
      end
    end

    describe "810" do
      it "should return data on 2024-01-01" do
        expect(data).to have_key(:NewDataSet)
      end
    end

    describe "813" do
      let(:par) { 1 }

      it "should return data on 2024-01-01" do
        expect(data).to have_key(:NewDataSet)
      end

      it "should return data parent organization on 2024-01-01" do
        expect(full).to have_key(:NewDataSet)
      end
    end

    describe "814" do
      it "should return data on 2024-01-01" do
        expect(data).to have_key(:NewDataSet)
      end
    end
  end
end
