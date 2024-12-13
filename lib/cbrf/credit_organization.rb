# frozen_string_literal: true

module Cbrf
  class CreditOrganization
    extend Forwardable

    def initialize(id)
      @id = Id.new(id)
    end

    def_delegator :@id, :bic, :internal_code, :registry_number
    def_delegator self, :client

    def info
      client.call(:CreditInfoByIntCode, { InternalCode: })
    end

    def info_short
      client.call(:CreditInfoByRegCodeShort, { CredorgNumber: })
    end

    class << self
      def client
        Soap::Client.new("https://www.cbr.ru/CreditInfoWebServ/CreditOrgInfo.asmx")
      end

      def last_update
        client.call(:LastUpdate)
      end

      def bics
        client.call(:EnumBIC)
      end

      def licences
        client.call(:EnumLicenses)
      end
    end
  end
end
