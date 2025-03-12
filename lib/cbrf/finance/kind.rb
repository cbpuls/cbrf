# frozen_string_literal: true

module Cbrf
  module Finance
    Kind = Struct.new(:code, :name, :short_name) do
      def self.all
        Api.call(:EnumFOVids).value[:FOVid].map { new(it[:Code], it[:Name], it[:ShortName]) }
      end
    end
  end
end
