# frozen_string_literal: true

module Cbrf
  module Finance
    module_function

    def version
      DateTime.xmlschema Api.call(:GetLastUpdate).value
    end
  end
end
