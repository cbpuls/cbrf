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
        # @schema ||= Schema.new Ox.load(xml, mode: :hash)
      end

      def diff
        @diff ||= Ox.load(xml, mode: :hash_no_attrs)
                    .dig(:"soap:Envelope", :"soap:Body", :"#{name}Response", :"#{name}Result", :"diffgr:diffgram")
      end

      alias to_h diff

      def value
        Ox.load(xml, mode: :hash_no_attrs).dig(:"soap:Envelope", :"soap:Body", :"#{name}Response", :"#{name}Result")
      end
    end
  end
end
