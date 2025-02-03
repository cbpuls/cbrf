# frozen_string_literal: true

module Cbrf
  Region = Struct.new(:id, :name) do
    def branches(name = nil)
      CreditOrganization::Api.call(:SearcBranches, name:, rgn: id).diff.dig(:SearcBranches, :BR)&.map do
        CreditOrganization::Office.new(
          id: CreditOrganization::Id.new(registry_number: it[:Regnum]),
          name: it[:Name],
          full_name: it[:cnamer],
          address: it[:Addr],
          credit_organization_id: CreditOrganization::Id.new(internal_code: it[:IntCode], registry_number: it[:cregnum],
                                                             cregnr: it[:cregnr])
        )
      end
    end

    # Offices credit organization by region
    def offices
      CreditOrganization::Api.call(:GetOfficesByRegion, RegCode: id).diff.dig(:CoOffices, :Offices)&.map do
        CreditOrganization::Office.new(
          id: CreditOrganization::Id.new(registry_number: it[:cregnum]),
          name: it[:cname],
          address: it[:straddrmn],
          registered_on: it[:cndate],
          credit_organization_id: CreditOrganization::Id.new(internal_code: it[:cmain])
        )
      end
    end

    # Return credit organizatins by region
    def credit_organizations
      CreditOrganization::Api.call(:SearchByRegionCode, RegCode: id).diff.dig(:CreditOrg, :EnumCredits)&.map do
        id = CreditOrganization::Id.new(bic: it[:bic], internal_code: it[:IntCode], registry_number: it[:cregnum],
                                        cregnr: it[:cregnr])
        CreditOrganization.new(id:, name: it[:OrgName], ogrn: it[:OGRN])
      end
    end

    # Return list regions
    def self.all
      CreditOrganization::Api.call(:RegionsEnum).diff.dig(:RegionsEnum, :RGID).map { new(it[:RegCode], it[:CNAME]) }
    end
  end
end
