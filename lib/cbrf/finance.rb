# frozen_string_literal: true

module Cbrf
  # (Docs)[https://www.cbr.ru/FO_ZoomWS/FinOrg.asmx]
  module Finance
    module_function

    # Return date last update in database Finance
    def version
      DateTime.xmlschema Api.call(:GetLastUpdate).value
    end
  end
end
