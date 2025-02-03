# frozen_string_literal: true

require "forwardable"

module Cbrf
  class CreditOrganization
    extend Forwardable

    def initialize(id:, name: nil, full_name: nil, address: nil, legal_address: nil, ogrn: nil, note: nil)
      @id = Conversions::Id(id)
      @name = name
      @full_name = full_name
      @address = address
      @legal_address = legal_address
      @ogrn = ogrn
      @note = note
    end

    def_delegators :@id, :bic, :internal_code, :registry_number

    def info
      Api.call(:CreditInfoByIntCode, InternalCode: internal_code).to_h
    end

    def note
      Api.call(:CreditInfoByRegCodeShort, { CredorgNumber: registry_number }).to_h
    end

    def fbu
      Api.call(:GetFBU, IntCode: internal_code).diff
    end

    def offices
      Api.call(:GetOffices, IntCode: internal_code).diff.dig(:CoOffices, :Offices)
    end

    def periods
      Api.call(:GetPeriodsOfDocuments, InternalCode: internal_code).result[:Docs]
    end

    def cards
      Api.call(:GeCards, InternalCode: internal_code).diff
    end

    def agencies
      Api.call(:GetAgency, IntCode: internal_code).diff.dig(:Agency, :AG)
    end

    def balance(year)
      case year
      when 1998
        Api.call(:GetBalance98, regnum: registry_number).result
      end
    end

    def bankrupt
      Api.call(:GetBankrots, InternalCode: internal_code).diff
    end

    def sites
      Api.call(:GetSites, InternalCode: internal_code).diff.dig(:CredorgSites, :SC)
    end

    def form(type)
      Form.new(type, registry_number)
    end

    class << self
      def find(code)
        id = Conversions::Id(code)

        Api.call(:CreditInfoByRegCodeShort, CredorgNumber: id.registry_number).diff.then do
          new(
            id: Id.new(bic: it[:bic], registry_number: it[:cregnum], cregnr: it[:cregnr]),
            name: it[:cnamer],
            full_name: it[:cname],
            address: it[:strcaddrmn],
            legal_address: it[:strcuraddr],
            ogrn: it[:ogrn]
          )
        end
      end

      def full(*ids)
        case ids.size
        when 1
          find_one(ids.first)
        else
          find_some(*ids)
        end
      end

      def find_one(code)
        id = Conversions::Id(code)
        Api.call(:CreditInfoByIntCode, InternalCode: id.internal_code).diff[:CreditOrgInfo]
      end

      def find_some(*args)
        ids = args.map { Conversions::Id(it) }
        Api.call(:CreditInfoByIntCodeEx, InternalCodes: ids.map(&:internal_code)).diff[:CreditOrgInfo]
      end

      def search(name)
        Api.call(:SearchByName, NamePart: name).diff.dig(:CreditOrg, :EnumCredits)&.map do
          new(
            id: Id.new(internal_code: it[:IntCode], bic: it[:bic], registry_number: it[:cregnum],
                       cregnr: it[:cregnr]),
            name: it[:OrgName], ogrn: it[:OGRN]
          )
        end
      end

      def search_by(name: nil, region: nil, nsitype: nil, status: nil, license: nil, fo: nil, cards: nil, fshare: nil,
                    jstock: nil)
        params = { NamePart: name }
        Api.call(:SearchByNameEx, params).diff.dig(:CreditOrg, :sn)&.map do
          id = Id.new(internal_code: it[:IntCode], registry_number: it[:cregnum], cregnr: it[:cregnr])
          new(id:, name: it[:OrgName], ogrn: it[:OGRN], legal_address: it[:strcuraddr], note: it[:cistate])
        end
      end

      def last_update
        DateTime.xmlschema Api.call(:LastUpdate).value
      end

      def sites(name:, url:)
        Api.call(:GetSitesFull, name:, url:).diff.dig(:CredorgSites)
      end

      def regions
        Region.all
      end

      def licenses
        License.all
      end
    end
  end
end
