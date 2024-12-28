# frozen_string_literal: true

module Cbrf
  class CreditOrganization::Id
    attr_reader :bic

    def initialize(key)
      key_str = key.to_s
      if key_str.start_with?("0")
        @bic = key_str
      elsif key_str.length < 8
        @registry_number = key_str
      else
        @internal_code = key_str
      end
    end

    def internal_code
      name, params = bic ? [:BicToIntCode, { BicCode: @bic }] : [:RegNumToIntCode, { RegNumber: @registry_number }]
      @internal_code ||= CreditOrganization::Api.call(name, params).value
    end

    def registry_number
      name, params = bic ? [:BicToRegNumber, { BicCode: @bic }] : [:IntCodeToRegNum, { IntNumber: @internal_code }]
      @registry_number ||= CreditOrganization::Api.call(name, params).value
    end
  end
end
