# frozen_string_literal: true

module Cbrf
  module Credit
    RSpec.describe Organization, :vcr, credit: :banks do
      let(:org_all) { Organization.all }

      describe "#id" do
        it "if set bic" do
          expect(Organization.new(bic: sber.bic).id).to eq sber.id
        end

        it "if set registry_no" do
          expect(Organization.new(registry_no: sber.registry_no).id).to eq sber.id
        end
      end

      describe "#registry_no" do
        it "if set bic" do
          expect(Organization.new(bic: sber.bic).registry_no).to eq sber.registry_no
        end

        it "if set id" do
          expect(Organization.new(id: sber.id).registry_no).to eq sber.registry_no
        end
      end

      describe "#all" do
        it { expect(org_all).to all be_a Organization }
      end

      describe "#to_h" do
        it {
          expect(org_all.first.to_h).to eq({ id: 10_000_012,
                                             bic: "040173745",
                                             ogrn: 1_022_200_525_819,
                                             registry_no: 2015,
                                             name: "СИБСОЦБАНК" })
        }
      end

      describe "#find" do
        let(:finded_keys) { %i[CO LIC] }

        it "should return info sberbank" do
          expect(described_class.find(sber.id).keys).to eq finded_keys
        end

        it "should return info sberbank and alfabank together" do
          expect(described_class.find(sber.id, alfa.id).keys).to eq %i[CO LIC]
        end

        it "should return info by all organization" do
          expect(described_class.find(org_all).keys).to eq finded_keys
        end

        it "should return info by all ids" do
          expect(described_class.find(org_all.map(&:id)).keys).to eq finded_keys
        end
      end

      describe "#short" do
        it { expect(sber.short.keys).to eq %i[cnamer cname strcaddrmn strcuraddr cregnr bic ogrn cregnum] }
      end

      describe "#full" do
        it { expect(sber.full.keys).to eq %i[CO LIC] }
      end
    end
  end
end
