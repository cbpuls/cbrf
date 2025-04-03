# frozen_string_literal: true

module Cbrf
  module Credit
    RSpec.describe Form, :vcr, credit: :banks do
      let(:code) { self.class.description }
      let(:organization) { sber }
      subject { Form.new(code, organization) }
      let(:date) { Date.new 2025, 1, 1 }
      let(:data) { subject.on date }
      let(:dates) { subject.dates }
      let(:max) { Form.max(code) }

      describe "101" do
        it "should return data on 2025-01-01" do
          expect(data[:F101FNew]).to include(:F101, :F1011)
        end

        it "should return dates" do
          expect(dates).not_to be_empty
        end

        it "should return max date" do
          expect(max).to eq DateTime.new(2025, 3, 1, 0, 0, 0)
        end

        it "should return indicators" do
          expect(Form.indicators(code)).to all be_a Form::Indicator
        end
      end

      describe "102" do
        it "should return data on 2025-01-01" do
          expect(data[:F102FNew]).to include(:F102, :F1021)
        end

        it "should return dates" do
          expect(dates).not_to be_empty
        end

        it "should return max date" do
          expect(max).to eq DateTime.new(2025, 3, 1, 0, 0, 0)
        end

        it "should return indicators" do
          expect(Form.indicators(code)).to all be_a Form::Indicator
        end
      end
    end
  end
end
