# frozen_string_literal: true

module Cbrf
  CreditOrganization::Api = Soap::Service.new("https://www.cbr.ru/CreditInfoWebServ/CreditOrgInfo.asmx")
end
