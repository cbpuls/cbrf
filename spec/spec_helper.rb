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
  RSpec.shared_context "banks", shared_context: :metadata do
    let(:sber) do
      CreditOrganization::Id.new(bic: "044525225", internal_code: "350_000_004", registry_number: 1481)
    end
    let(:alfa) do
      CreditOrganization::Id.new(bic: "044525593", internal_code: "450_000_036", registry_number: 1326)
    end
    let(:vtb) do
      CreditOrganization::Id.new(bic: "044525187", internal_code: "350_000_008", registry_number: 1000)
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

  config.include_context "banks", with_banks: true
  config.include_context "regions", with_regions: true
end
