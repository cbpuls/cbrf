# frozen_string_literal: true

module Cbrf
  module Finance
    Type = Struct.new(:code, :name) do
      def self.all
        Api.call(:EnumFOTypes).value[:FOType].map { new(it[:Code], it[:Name]) }
      end
    end
  end
end
