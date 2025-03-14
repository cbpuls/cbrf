# frozen_string_literal: true

require "webmock/rspec"
require "cbrf"
require "vcr"

VCR.configure do |c|
  c.cassette_library_dir = "spec/cassettes"
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

module Cbrf
  module Credit
    RSpec.shared_context "credit organizations", shared_context: :metadata do
      let(:sber) do
        Organization.new(id: 350_000_004, bic: "044525225", ogrn: 1_027_700_132_195,
                         registry_no: 1481, name: "СБЕРБАНК")
      end

      let(:alfa) do
        Organization.new(id: 450_000_036, bic: "044525593", ogrn: 1_027_700_067_328, registry_no: 1326,
                         # registered_on: DateTime.xmlschema("1991-01-03T00:00:00+03:00"),
                         name: "АЛЬФА-БАНК")
      end

      let(:yandex) do
        Organization.new(id: 450_000_804, bic: "044525677", ogrn: 1_077_711_000_091, registry_no: 3027,
                         # registered_on: DateTime.xmlschema("1994-08-04T00:00:00+04:00"),
                         name: "ЯНДЕКС")
      end

      let(:ozon) do
        Organization.new(id: 512_056_749, bic: "044525068", ogrn: 1_227_700_133_792,
                         registry_no: 3542,
                         # registered_on: DateTime.xmlschema("2022-03-11T00:00:00+03:00"),
                         name: "ОЗОН БАНК")
      end
    end

    RSpec.shared_context "banks", shared_context: :metadata do
      let(:sber) do
        Id.new(bic: "044525225", internal_code: 350_000_004, registry_no: 1481)
      end
      let(:alfa) do
        Id.new(bic: "044525593", internal_code: 450_000_036, registry_no: 1326)
      end
      let(:vtb) do
        Id.new(bic: "044525187", internal_code: 350_000_008, registry_no: 1000)
      end
    end
  end

  RSpec.shared_context "regions", shared_context: :metadata do
    let(:moscow) { Region.new(16, "Москва") }
    let(:saint_petersburg) { Region.new(3, "Санкт-Петербург") }
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include_context "credit organizations", credit: :banks

  config.include_context "banks", with_banks: true
  config.include_context "regions", with_regions: true
end
