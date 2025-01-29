# frozen_string_literal: true

module Cbrf
  module Conversions
    module_function

    def Id(code)
      case code
      when CreditOrganization::Id
        code
      when String
        CreditOrganization::Id.new CreditOrganization::Id.id_key(code) => code
      when Integer
        CreditOrganization::Id.new CreditOrganization::Id.id_key(code.to_s) => code
      end
    end

    refine Hash do
      def to_co
        # pp self
      end

      def to_region
        Region.new(self[:RegCode], self[:CNAME])
      end
    end
  end
end
