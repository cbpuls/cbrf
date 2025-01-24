# frozen_string_literal: true

require "forwardable"

module Cbrf
  class CreditOrganization
    extend Forwardable

    def initialize(id)
      @id = Id.new(id)
    end

    def_delegators :@id, :bic, :internal_code, :registry_number

    def info
      Api.call(:CreditInfoByIntCode, { InternalCode: internal_code }).to_h
    end

    def note
      Api.call(:CreditInfoByRegCodeShort, { CredorgNumber: registry_number }).to_h
    end

    def fbu
      Api.call(:GetFBU, IntCode: internal_code).result
    end

    def offices
      Api.call(:GetOffices, IntCode: internal_code).diff
    end

    def offices_in(region)
      Api.call(:GetOfficesByRegion, RegCode: region).diff
    end

    def periods
      Api.call(:GetPeriodsOfDocuments, InternalCode: internal_code).result
    end

    def cards
      Api.call(:GeCards, InternalCode: internal_code).xml
    end

    def agencies
      Api.call(:GetAgency, IntCode: internal_code).diff
    end

    def bankrupt
      Api.call(:GetBankrots, InternalCode: internal_code).diff
    end

    def sites
      Api.call(:GetSites, InternalCode: internal_code).diff
    end

    def search(name)
      Api.call(:SearcBranches, name:, rgn: registry_number).diff
    end

    def form(type)
      Form.new(type, registry_number)
    end

    class << self
      def search(name)
        Api.call(:SearchByName, NamePart: name).diff
      end

      def last_update
        DateTime.xmlschema Api.call(:LastUpdate).value
      end

      def regions
        Api.call(:RegionsEnum).diff
      end

      def bics
        Api.call(:EnumBIC).to_h
      end

      def licenses
        Api.call(:EnumLicenses).to_h
      end

      def info(*codes)
        Api.call(:CreditInfoByIntCodeEx, { InternalCodes: codes }).to_h
      end
    end
  end
end
