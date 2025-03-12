# frozen_string_literal: true

module Cbrf
  Finance::Api = Soap::Service.new("https://www.cbr.ru/FO_ZoomWS/FinOrg.asmx")
end
