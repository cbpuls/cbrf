# frozen_string_literal: true

# require "webmock/rspec"
require "cbrf"

Bank = Struct.new(:bic, :internal_code, :registry_number)

RSpec.shared_context "banks", shared_context: :metadata do
  let(:sber) { Bank.new("044525225", 350_000_004, 1481) }
  let(:alfa) { Bank.new("044525593", 450_000_036, 1326) }
  let(:vtb)  { Bank.new("044525187", 350_000_008, 1000) }
end

RSpec.shared_context "regions", shared_context: :metadata do
  let(:moscow) { Cbrf::Region.new(16, "Москва") }
  let(:saint_petersburg) { Cbrf::Region.new(3, "Санкт-Петербург") }
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
