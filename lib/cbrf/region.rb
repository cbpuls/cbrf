# frozen_string_literal: true

module Cbrf
  Region = Struct.new(:id, :name) do
    def offices
      pp Cbrf::CreditOrganization::Api.call(:GetOfficesByRegion, RegCode: id).diff
    end

    # Return credit organizatins by region
    # Schema:
    # [{name: "IntCode", "msdata:Caption": "Вн. код КО", type: "xs:decimal", minOccurs: "0"}],
    # [{name: "OrgName", "msdata:Caption": "Название орг.", type: "xs:string", minOccurs: "0"}],
    # [{name: "bic", "msdata:Caption": "Код BIC", type: "xs:string", minOccurs: "0"}],
    # [{name: "cregnr", type: "xs:string", minOccurs: "0"}],
    # [{name: "cregnum", "msdata:Caption": "рег. номер", type: "xs:decimal", minOccurs: "0"}],
    # [{name: "OGRN", "msdata:Caption": "ОГРН", type: "xs:string", minOccurs: "0"}]
    def credit_organizations
      CreditOrganization::Api.call(:SearchByRegionCode, RegCode: id).diff.dig(:CreditOrg, :EnumCredits).map(&:to_co)
    end

    # Return list regions
    def self.all
      CreditOrganization::Api.call(:RegionsEnum).diff.dig(:RegionsEnum, :RGID).map { new(it[:RegCode], it[:CNAME]) }
    end
  end
end
