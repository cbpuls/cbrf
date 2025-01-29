# frozen_string_literal: true

module Cbrf
  CreditOrganization::License = Struct.new(:id, :name, :short) do
    def self.all
      Cbrf::CreditOrganization::Api.call(:EnumLicenses).diff.dig(:Licens, :LIC).map do
        new(it[:ccode], it[:cname], it[:cabrv])
      end
    end
  end
end
