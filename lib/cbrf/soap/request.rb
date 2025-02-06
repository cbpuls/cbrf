# frozen_string_literal: true

module Cbrf
  module Soap
    class Request
      attr_reader :doc

      def initialize(name)
        @doc = Ox::Document.new << instruct
        @doc << (envelope << (Ox::Element.new("soap12:Body") << (@msg = Ox::Element.new(name))))
        @msg[:xmlns] = "http://web.cbr.ru/"
      end

      def instruct
        Ox::Instruct.new(:xml).tap do
          _1[:version] = "1.0"
          _1[:encoding] = "UTF-8"
        end
      end

      def envelope
        Ox::Element.new("soap12:Envelope").tap do |node|
          { "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance",
            "xmlns:xsd" => "http://www.w3.org/2001/XMLSchema",
            "xmlns:soap12" => "http://www.w3.org/2003/05/soap-envelope" }.each do |prefix, href|
            node[prefix] = href
          end
        end
      end

      def with(args = {})
        args.each do |name, content|
          if content.respond_to?(:each)
            @msg << (submsg = Ox::Element.new(name))
            content.each do |e|
              submsg << (Ox::Element.new("double") << e.to_s)
            end
          else
            @msg << (Ox::Element.new(name) << content.to_s)
          end
        end
        self
      end

      def to_xml
        Ox.dump(@doc)
      end
    end
  end
end
