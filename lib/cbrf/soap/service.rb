# frozen_string_literal: true

require "uri"
require "net/http"

module Cbrf
  module Soap
    class Service
      attr_reader :uri

      def initialize(url)
        @uri = URI(url)
      end

      def call(name, args = {})
        res = Net::HTTP.post(uri, Request.new(name).with(args).to_xml,
                             { "content-type": "application/soap+xml; charset=utf-8" })
        case res
        when Net::HTTPSuccess
          Response.new(name, res.body)
        else
          res.value
        end
      end
    end
  end
end
