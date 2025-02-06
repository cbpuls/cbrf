# frozen_string_literal: true

module Cbrf
  class CreditOrganization::Form
    attr_reader :type, :id

    def initialize(type)
      @type = type.to_i
    end

    def <<(registry_number)
      @id = registry_number.to_i
      self
    end

    def on_date_params
      case type
      when 101 then %i[Data101FNew dt]
      when 102 then %i[Data102F dt]
      when 123 then %i[Data123bF Dt]
      when 134 then %i[Data134bF Dt]
      when 135 then %i[Data135FormFull OnDate]
      when 802 then %i[Data802F Dt]
      when 803 then %i[Data803F Dt]
      when 805, 806, 807, 808, 810, 813, 814 then [:"GetF#{type}Data", :dateTime]
      end
    end

    def on(date, par = nil)
      operation, key = on_date_params

      args = { CredorgNumber: id, key => date }
      args[:par] = par if par

      CreditOrganization::Api.call(operation, args).diff
    end

    def full_on_params
      case type
      when 123 then %i[Data123FormFull OnDate]
      when 808, 813 then ["GetF#{type}BGData", :dateTime]
      end
    end

    def full_on(date, par = nil)
      operation, key = full_on_params
      args = { CredorgNumber: id, key => date }
      args[:par] = par if par

      CreditOrganization::Api.call(operation, args).diff
    end

    def meta(date)
      CreditOrganization::Api.call(:Data135MetaFull, CredorgNumber: id, OnDate: date.to_s).diff
    end

    def by(indicator, from:, to:, ids: nil)
      key = case type
            when 101 then :IndCode
            when 102 then :SymbCode
            end

      if ids.nil?
        operation = case type
                    when 101 then :Data101FullV2
                    when 102 then :Data102Form
                    end
        args = { CredorgNumber: id }
      else
        operation = case type
                    when 101 then :Data101FullExV2
                    when 102 then :Data102FormEx
                    end
        args = { CredorgNumbers: ids }
      end
      args[key] = indicator
      args[:DateFrom] = from
      args[:DateTo] = to

      CreditOrganization::Api.call(operation, args).diff
    end

    def dates
      CreditOrganization::Api.call(:"GetDatesForF#{type}", CredprgNumber: id).result[:dateTime]
    end

    def max
      DateTime.xmlschema CreditOrganization::Api.call(:GetFormsMaxDate, code: type).result
    end

    def indicators
      CreditOrganization::Api.call(:"Form#{type}IndicatorsEnum").diff.dig(:"IndicatorsEnum#{type}",
                                                                          :"#{type.to_i == 101 ? "E" : "S"}IND")&.map do
        if type.to_i == 101
          CreditOrganization::Indicator.new(id: it[:IndID], code: it[:IndCode], name: it[:name], type: it[:IndType],
                                            chapter: it[:IndChapter])
        else
          CreditOrganization::Indicator.new(id: it[:symid], code: it[:symbol], name: it[:name], type: it[:symtype],
                                            symset: it[:symset], symsort: it[:symsort])
        end
      end
    end
  end
  Form = Struct.new(:type, :registry_number) do
    def on(date)
      operation, key, = params
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
      #
      # pp CreditOrganization::Api.call(operation, CredorgNumber: registry_number, key => date.to_s).schema
      CreditOrganization::Api.call(operation, CredorgNumber: registry_number, key => date.to_s).diff
    end

    def meta(date); end

    # def full(date)
    # end

    def by(indicator, from:, to:)
      operation, key = case type.to_i
                       when 101 then %i[Data101FullV2 IndCode]
                       when 102 then %i[Data102Form SymbCode]
                       end
      CreditOrganization::Api.call(operation, CredorgNumber: registry_number, key => indicator, DateFrom: from.to_s,
                                              DateTo: to.to_s).to_hash
    end

    def revenue_by(indicator, from:, to:)
      CreditOrganization::Api.call(:Data101FullV2, CredorgNumber: registry_number, IndCode: indicator,
                                                   DateFrom: from.to_s, DateTo: to.to_s).schema
    end
  end
end
