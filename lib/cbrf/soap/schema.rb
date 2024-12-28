# frozen_string_literal: true

module Cbrf
  module Soap
    class Schema
      attr_accessor :value

      extend Forwardable
      def_delegator :@buffer, :[]

      def initialize(doc)
        @doc = doc
        @buffer = {}
        @value = {}
      end

      def <<(key)
        case @buffer[key]
        when Array then @buffer[key] << @value
        when Hash then @buffer[key] = [@buffer[key], @value]
        when nil then @buffer[key] = @value
        end
      end

      def []=(key, value)
        pp key, value
      end

      def to_hash
        @buffer
      end

      def execute(node)
        node.to_schema(self)
      end
    end
  end
end
