# frozen_string_literal: true

module Cbrf
  module Conversions
    module_function

    def Organization(code)
      case code
      when Credit::Organization
        code
      when String
        Credit::Organization.new to_name_id(code) => code
      when Integer
        Credit::Organization.new to_name_id(code.to_s) => code
      end
    end

    def to_name_id(code)
      if code.start_with?("04")
        :bic
      elsif code.length <= 4
        :registry_no
      else
        :id
      end
    end

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
