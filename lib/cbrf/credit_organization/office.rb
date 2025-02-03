# frozen_string_literal: true

module Cbrf
  CreditOrganization::Office = Struct.new(:id, :name, :full_name, :address, :registered_on, :credit_organization_id)
end
