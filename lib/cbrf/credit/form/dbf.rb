# frozen_string_literal: true

require "ffi-libarchive"
require "dbf"

module Cbrf
  module Credit
    # [Docs](https://www.cbr.ru/banking_sector/otchetnost-kreditnykh-organizaciy/)
    class Form::Dbf
      BASE_URL = "https://www.cbr.ru/vfs/credit/forms"
      attr_reader :code, :date

      def initialize(code)
        @code = code.to_i
        @buffer = {}
      end

      def on(date)
        tap do
          @date = date << 1
          parse(date) if date
        end
      end

      def parse(date)
        url = "#{BASE_URL}/#{code}-#{date.strftime("%Y%m%d")}.rar"
        archive = rar(url)
        return if archive.nil?

        reader = Archive::Reader.open_filename rar(url).path

        reader.each_entry_with_data do |entry, data|
          @buffer[entry.pathname] = DBF::Table.new(StringIO.new(data), nil, "cp866")
        end

        reader.close
      end

      def rar(url)
        URI.parse(url).open(open_timeout: 1, read_timeout: 1)
      rescue OpenURI::HTTPError => e
        raise Cbrf::NotFound.new(e.message) if e.message == "404 Not Found"
      end

      def data
        @buffer[data_key]
      end

      def data_key
        case code
        when 101 then date.strftime("%m%Y") + "B1.dbf"
        end
      end

      def organizations
        @buffer[organizations_key]
      end

      def organizations_key
        case code
        when 101 then date.strftime("%m%Y") + "N1.dbf"
        end
      end

      def indicators
        @buffer[indicators_key]
      end

      def indicators_key
        case code
        when 101 then "NAMES.dbf"
        end
      end
    end
  end
end
