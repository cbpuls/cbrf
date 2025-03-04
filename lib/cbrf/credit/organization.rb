# frozen_string_literal: true

module Cbrf
  module Credit
    class Organization
      class << self
        # Full information about credit organization
        def find(*codes)
          case codes.size
          when 0
            raise ArgumentError
          when 1
            find_one(codes.first)
          else
            find_some(codes)
          end
        end

        def find_one(code)
          id = Id.new(code)
          Api.call(:CreditInfoByIntCode, InternalCode: id.internal_code).diff[:CreditOrgInfo]
        end

        def find_some(codes)
          ids = codes.map { Id.new it }
          Api.call(:CreditInfoByIntCodeEx, InternalCodes: ids.map(&:internal_code)).diff[:CreditOrgInfo]
        end
      end
    end
  end
end
