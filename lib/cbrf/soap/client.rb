# frozen_string_literal: true

module Cbrf
  module Soap
    class Client
      def initialize(url)
        @uri = URI(url)
      end

      def call(name, args)
        Net::HTTP.post(
          uri,
          Message.new(name).with(args),
          { "content-type": "application/soap+xml; charset=utf-8" }
        )
      end
    end
  end
end
