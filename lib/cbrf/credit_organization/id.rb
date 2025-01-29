# frozen_string_literal: true

module Cbrf
  class Cbrf::CreditOrganization::Id
    attr_reader :bic, :cregnr

    def initialize(internal_code: nil, bic: nil, registry_number: nil, cregnr: nil)
      @internal_code = internal_code&.to_i
      @bic = bic
      @registry_number = registry_number&.to_i
      @cregnr = cregnr
    end

    def internal_code
      name, params = if bic
                       [:BicToIntCode, { BicCode: @bic }]
                     else
                       [:RegNumToIntCode, { RegNumber: @registry_number }]
                     end
      @internal_code ||= CreditOrganization::Api.call(name, params).value.to_i
    end

    def registry_number
      name, params = if bic
                       [:BicToRegNumber, { BicCode: @bic }]
                     else
                       [:IntCodeToRegNum, { IntNumber: @internal_code }]
                     end
      @registry_number ||= CreditOrganization::Api.call(name, params).value.to_i
    end

    class << self
      # Return all bics
      def bics
        CreditOrganization::Api.call(:EnumBIC).diff.dig(:EnumBIC, :BIC)
      end

      # Return all id from API
      def all
        bics.map { new(internal_code: it[:intCode], registry_number: it[:RN], bic: it[:BIC], cregnr: it[:cregnr]) }
      end
    end
  end
end
