# frozen_string_literal: true

require "spec_helper"

RSpec.describe Cbrf::Client do
  describe "#last_update" do
    it "should return last update date from cbr.ru" do
      expect(subject.last_update).to be_a(DateTime)
    end
  end

  describe "#bics" do
    it "should return BIC codes credit organisations" do
      expect(subject.bics).not_to be_empty
      # expect(subject.schema).not_to be_empty
      # expect(subject.data.first.keys).to be == %w[BIC RC NM RB cregnr intCode RN]
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

  describe "#info" do
    it "should return info credit organisation" do
      expect(subject.info("350000004")).not_to be_empty
    end
  end

  describe "#search" do
    it "should return credit organisation" do
      expect(subject.search("Сбербанк России")).not_to be_empty
      expect(subject.data.first["IntCode"]).to eq("350000004")
    end
  end
end
