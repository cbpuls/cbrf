# frozen_string_literal: true

module Cbrf
  CreditOrganization::Form = Struct.new(:type, :registry_number) do
    Indicator = Struct.new(:id, :code, :name, :type, :sort, :set)

    def params
      case type.to_i
      when 101 then %i[Data101FNew dt F101FNew F101]
      end
    end

    def on(date)
      operation, key, key_1, key_2 = params
      # operation, key = case type.to_i
      #                  when 101 then %i[Data101FNew dt]
      #                  when 102 then %i[Data102F dt]
      #                  when 123 then %i[Data123bF Dt]
      #                  when 134 then %i[Data134bF Dt]
      #                  when 135 then %i[Data135FormFull OnDate]
      #                  when 802 then %i[Data802F Dt]
      #                  when 803 then %i[Data803F Dt]
      #                  when 806 then %i[GetF806Data dateTime]
      #                  when 810 then %i[GetF810Data dateTime]
      #                  when 814 then %i[GetF814Data dateTime]
      #                  end
      pp CreditOrganization::Api.call(operation, CredorgNumber: registry_number, key => date.to_s).diff.dig(key_1,
                                                                                                            key_2)
    end

    def meta(date)
      Cbrf::CreditOrganization::Api.call(:Data135MetaFull, CredorgNumber: registry_number, OnDate: date.to_s).diff
    end

    # def full(date)
    #   CreditOrganization::Api.call(:Data123FormFull, CredorgNumber: registry_number, OnDate: date.to_s).diff
    # end

    def by(indicator, from:, to:)
      operation, key = case type.to_i
                       when 101 then %i[Data101FullV2 IndCode]
                       when 102 then %i[Data102Form SymbCode]
                       end
      CreditOrganization::Api.call(operation, CredorgNumber: registry_number, key => indicator,
                                              DateFrom: from.to_s, DateTo: to.to_s).diff
    end

    def dates
      CreditOrganization::Api.call(:"GetDatesForF#{type}", CredprgNumber: registry_number).result[:dateTime]
    end

    def max
      DateTime.xmlschema CreditOrganization::Api.call(:GetFormsMaxDate, code: type).result
    end

    def indicators
      pp CreditOrganization::Api.call(:"Form#{type}IndicatorsEnum").diff
    end
  end
end
