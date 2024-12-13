# frozen_string_literal: true

module Cbrf
  module Soap
    class Message
      include LibXML

      def initialize(name)
        @doc = XML::Document.new
        XML::Node.new(name)
      end
    end
  end
end
