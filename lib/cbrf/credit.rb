# frozen_string_literal: true

module Cbrf
  module Credit
    module_function

    # Date last update credit organization database
    def version
      DateTime.xmlschema Api.call(:LastUpdate).value
    end
  end
end
