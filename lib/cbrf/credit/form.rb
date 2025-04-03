# frozen_string_literal: true

module Cbrf
  module Credit
    class Form
      attr_reader :code, :organization

      def initialize(code, organization)
        @code = code.to_i
        @organization = Conversions::Organization(organization)
      end

      def params
        case code
        when 101 then %i[Data101FNew dt]
        when 102 then %i[Data102F dt]
        end
      end

      def on(date)
        name, key_for_date = params
        args = { CredorgNumber: organization.registry_no, key_for_date => date }

        pp Api.call(name, args).dataset
      end

      def dates
        Api.call(:"GetDatesForF#{code}", CredprgNumber: organization.registry_no).result[:dateTime]
      end

      class << self
        def max(code)
          DateTime.xmlschema Api.call(:GetFormsMaxDate, code:).result
        end

        def indicators(code) = Indicator.all_for(code)
      end
    end
  end
end
