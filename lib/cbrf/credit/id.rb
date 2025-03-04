# frozen_string_literal: true

module Cbrf
  module Credit
    class Id
      attr_reader :bic

      def initialize(code = nil, internal_code: nil, registry_no: nil, bic: nil)
        convert code.to_s if code

        @internal_code ||= internal_code
        @registry_no ||= registry_no
        @bic ||= bic
      end

      def convert(code)
        if code.start_with?("0")
          @bic = code
        elsif code.length < 8
          @registry_no = code.to_i
        else
          @internal_code = code.to_i
        end
      end

      def internal_code
        name, params = if bic
                         [:BicToIntCode, { BicCode: @bic }]
                       else
                         [:RegNumToIntCode, { RegNumber: @registry_no }]
                       end
        @internal_code ||= CreditOrganization::Api.call(name, params).value.to_i
      end

      def registry_no
        name, params = if bic
                         [:BicToRegNumber, { BicCode: @bic }]
                       else
                         [:IntCodeToRegNum, { IntNumber: @internal_code }]
                       end
        @registry_no ||= CreditOrganization::Api.call(name, params).value.to_i
      end

      class << self
        def bics
          CreditOrganization::Api.call(:EnumBIC).diff.dig(:EnumBIC, :BIC)
        end

        def all
          bics.map { new(internal_code: it[:intCode], registry_no: it[:RN], bic: it[:BIC]) }
        end
      end
    end
  end
end
