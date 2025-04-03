# frozen_string_literal: true

module Cbrf
  module Credit
    Form::Indicator = Struct.new(:id, :code, :name, :type, :symsort, :symset, :chapter) do
      def self.all_for(code)
        Api.call(:"Form#{code}IndicatorsEnum").dataset
           .dig(:"IndicatorsEnum#{code}", :"#{code.to_i == 101 ? "E" : "S"}IND")&.map do
          if code.to_i == 101
            new(id: it[:IndID], code: it[:IndCode], name: it[:name], type: it[:IndType], chapter: it[:IndChapter])
          else
            new(id: it[:symid], code: it[:symbol], name: it[:name], type: it[:symtype], symset: it[:symset],
                symsort: it[:symsort])
          end
        end
      end
    end
  end
end
