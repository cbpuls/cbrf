# frozen_string_literal: true

module Cbrf
  module Conversions
    module_function

    def Id(key)
      key_str = key.to_s
      if key_str.start_with?("0")
        CreditOrganization::Id.new(bic: key_str)
      elsif key_str.length < 8
        CreditOrganization::Id.new(registry_number: key_str)
      else
        CreditOrganization::Id.new(internal_code: key_str)
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
