# frozen_string_literal: true

module Cbrf
  module Soap
    class Response
      attr_reader :name, :xml

      def initialize(name, xml)
        @name = name
        @xml = xml
      end

      def schema
        @schema ||= to_hash[:"soap:Envelope"].find { it.key?(:"soap:Body") }.dig(:"soap:Body", :"#{name}Response")
                                             .find { it.key?(:"#{name}Result") }.dig(:"#{name}Result", :"xs:schema")
      end

      def to_hash
        Ox.load(xml, mode: :hash)
      end

      def to_h
        Ox.load(xml, mode: :hash_no_attrs)
      end

      def diff
        @diff ||= to_h.dig(:"soap:Envelope", :"soap:Body", :"#{name}Response", :"#{name}Result", :"diffgr:diffgram")
      end

      def result
        @result ||= to_hash[:"soap:Envelope"].find { it.key?(:"soap:Body") }.dig(:"soap:Body", :"#{name}Response")
                                             .find { it.key?(:"#{name}Result") }.dig(:"#{name}Result")
      end

      def value
        @value ||= to_h.dig(:"soap:Envelope", :"soap:Body", :"#{name}Response", :"#{name}Result")
      end
    end
  end
end
