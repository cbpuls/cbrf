# frozen_string_literal: true

module Cbrf
  module Conversions
    refine Hash do
      def to_co
        pp self
      end

      def to_region
        Region.new(self[:RegCode], self[:CNAME])
      end
    end
  end
end
