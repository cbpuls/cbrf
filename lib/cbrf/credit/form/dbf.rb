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
      end

      def rar
        @rar ||= URI.parse(rar_url).open
      end

      def rar_url = "#{BASE_URL}/#{code}-#{date.strftime("%Y%m%d")}.rar"

      def data
        reader = Archive::Reader.open_filename rar.path

        reader.each_entry_with_data do |entry, data|
          pp entry.pathname
          items = DBF::Table.new(StringIO.new(data), nil, "cp866")
          items.each do |record|
            pp record.name
            pp record.num_sc
          end
        end
        reader.close
      end
    end
  end
end
