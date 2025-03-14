# frozen_string_literal: true

module Cbrf
  module Credit
    class Organization
      attr_reader :bic

      def initialize(id: nil, bic: nil, ogrn: nil, registry_no: nil, name: nil)
        @id = id
        @bic = bic
        @ogrn = ogrn
        @registry_no = registry_no
        @name = name
      end

      def id
        operation, params = @bic ? [:BicToIntCode, { BicCode: @bic }] : [:RegNumToIntCode, { RegNumber: @registry_no }]
        @id ||= Api.call(operation, params).result.to_i
      end

      def registry_no
        operation, params = @bic ? [:BicToRegNumber, { BicCode: @bic }] : [:IntCodeToRegNum, { IntNumber: @id }]
        @registry_no ||= Api.call(operation, params).result.to_i
      end

      # Short information about credit organization
      def short
        Api.call(:CreditInfoByRegCodeShort, CredorgNumber: registry_no).dataset.dig(:CredorgInfo, :is)
      end

      # Full information about credit organization
      def full
        @full ||= Organization.find_one id
      end

      class << self
        # Get all credit organizations with BIC
        def all
          Credit.bics.map do
            new(id: it[:intCode], bic: it[:BIC], ogrn: it[:RB], registry_no: it[:RN], name: it[:NM])
          end
        end

        def build(_code)
          organization
          Api.call(:CreditInfoByRegCodeShort, CredorgNumber: organization.registry_no)
        end

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
          organization = Conversions::Organization(code)
          Api.call(:CreditInfoByIntCode, InternalCode: organization.id).dataset[:CreditOrgInfo]
        end

        def find_some(codes)
          organizations = codes.map { Conversions::Organization it }
          Api.call(:CreditInfoByIntCodeEx, InternalCodes: organizations.map(&:id)).dataset[:CreditOrgInfo]
        end
      end
    end
  end
end
