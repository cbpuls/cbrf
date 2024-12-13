# frozen_string_literal: true

module Cbrf
  class CreditOrganization::Id
    attr_reader :bic

    def initialize(key)
      key_str = key.to_s
      if key_str.start_with?("0")
        @bic = key_str
      elsif key_str.lenght < 8
        @registry_number = key_str
      else
        @internal_code = key_str
      end
    end
  end
end
