# frozen_string_literal: true

module Cbrf
  module Finance
    class Organization
      class << self
        def find(id)
          Api.call(:GetFullInfoByOGRN, OGRN: id).to_hash
        end

        def all
          Api.call(:Search, Name: "", Addr: "", Status: "", FoType: "", VidID: "", OKATO: "", page: "")
        end
      end
    end
  end
end
