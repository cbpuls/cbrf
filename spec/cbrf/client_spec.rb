# frozen_string_literal: true

require "spec_helper"

RSpec.describe Cbrf::Client do
  subject { described_class.new }

  describe "#last_update" do
    it "should return last update date from cbr.ru" do
      expect(subject.last_update).to be_a(DateTime)
    end
  end

  describe "#bics" do
    it "should return BIC codes credit organisations" do
      expect(subject.bics).not_to be_empty
      expect(subject.schema).not_to be_empty
      expect(subject.data.first.keys).to be == %w[BIC RC NM RB cregnr intCode RN]
    end
  end

  describe "#licenses" do
    it "should return list licenses" do
      expect(subject.licenses).not_to be_empty
    end
  end

  describe "#regions" do
    it "should return list regions" do
      expect(subject.regions).not_to be_empty
    end
  end
end
