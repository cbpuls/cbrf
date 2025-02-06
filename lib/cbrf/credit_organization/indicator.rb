# frozen_string_literal: true

module Cbrf
  CreditOrganization::Indicator = Struct.new(:id, :code, :name, :type, :symsort, :symset, :chapter)
end
