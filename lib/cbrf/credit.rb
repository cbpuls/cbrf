# frozen_string_literal: true

module Cbrf
  # (Docs)[https://www.cbr.ru/CreditInfoWebServ/CreditOrgInfo.asmx]
  module Credit
    module_function

    # def test
    #   pp Api.call(:SearchByName, NamePart: "").to_h
    # end

    # Date last update credit database
    def version
      Api.call(:LastUpdate).value
    end

    # Return all credit organizations with bics in hash format
    def bics
      Api.call(:EnumBIC).dataset.dig(:EnumBIC, :BIC)
    end

    # Return all regions in credit organizations database
    def regions
      Api.call(:EnumRegions).dataset.dig(:EnumRegions, :ER)
    end
  end
end
