# frozen_string_literal: true

require "ffi-libarchive"
require "dbf"

module Cbrf
  module Credit
    # [Docs](https://www.cbr.ru/banking_sector/otchetnost-kreditnykh-organizaciy/)
    class Form::Dbf
      BASE_URL = "https://www.cbr.ru/vfs/credit/forms"
      attr_reader :code, :date

      def initialize(code, date)
        @code = code.to_i
        @date = date
        @buffer = {}
      end

      def rar
        @rar ||= URI.parse(rar_url).open
      end

      def rar_url = "#{BASE_URL}/#{code}-#{date.strftime("%Y%m%d")}.rar"

      def reader
        @reader ||= Archive::Reader.open_filename rar.path
      end

      def buffer
        parse if @buffer.empty?
        @buffer
      end

      def parse
        reader.each_entry_with_data do |entry, data|
          @buffer[entry.pathname] = DBF::Table.new(StringIO.new(data), nil, "cp866")
        end

        reader.close
      end

      def data
        pp buffer.keys
        buffer["B1.DBF"]
      end

      def organizations
        buffer[""]
      end

      def indicators
        buffer[""]
      end
    end
  end
end
