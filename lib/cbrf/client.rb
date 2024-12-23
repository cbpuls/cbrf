# frozen_string_literal: true

require "date"
require "net/http"
require "uri"
require "libxml-ruby"

module Cbrf
  class Client
    attr_reader :xml, :data

    def url = URI("https://www.cbr.ru/CreditInfoWebServ/CreditOrgInfo.asmx")

    def doc
      @doc ||= LibXML::XML::Parser.string(xml).parse
    end

    def schema
      @schema ||= doc.find("//xs:schema//xs:sequence/xs:element", "xs:http://www.w3.org/2001/XMLSchema").map { |node| node.attributes.to_h }
    end

    def find(xpath)
      doc.find(xpath).map do
        _1.inject({}) do |hash, node|
          hash.merge node.name => node.content
        end
      end
    end

    # Return last update date
    #
    # @param
    # @return
    # @example
    #   Cbrf.last_update
    def last_update
      uri = URI("https://www.cbr.ru/CreditInfoWebServ/CreditOrgInfo.asmx")
      request = Net::HTTP::Post.new(uri)
      request.body = <<~XML
        <?xml version="1.0" encoding="utf-8"?>
        <soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
          <soap12:Body>
            <LastUpdate xmlns="http://web.cbr.ru/" />
          </soap12:Body>
        </soap12:Envelope>
      XML
      request.content_type = "text/xml; charset=utf-8"
      response = Net::HTTP.start(uri.hostname) do |http|
        http.request request
      end
      response.body
      xml = LibXML::XML::Parser.string(response.body)
      DateTime.xmlschema xml.parse.last.content
    end

    def licenses
      @xml = fetch('<EnumLicenses xmlns="http://web.cbr.ru/" />')
      @data = find("//LIC")
    end

    def regions
      @xml = fetch('<EnumRegions xmlns="http://web.cbr.ru/" />')
      @data = find("//ER")
    end

    # Return BIC credit organisations
    def bics
      @xml = fetch('<EnumBIC xmlns="http://web.cbr.ru/" />')
      @data = find("//BIC")
    end

    def info(code)
      @xml = fetch(
        <<~XML
          <CreditInfoByIntCode xmlns="http://web.cbr.ru/">
            <InternalCode>#{code}</InternalCode>
          </CreditInfoByIntCode>
        XML
      )
      @data = find("//CO")
    end

    def search(name)
      @xml = fetch(
        <<~XML
          <SearchByName xmlns="http://web.cbr.ru/">
            <NamePart>#{name}</NamePart>
          </SearchByName>
        XML
      )
      @data = find("//EnumCredits")
    end

    def fetch(query)
      data = <<~XML
        <?xml version="1.0" encoding="utf-8"?>
        <soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
          <soap12:Body>
            #{query}
          </soap12:Body>
        </soap12:Envelope>
      XML

      headers = { "content-type": "application/soap+xml; charset=utf-8" }
      response = Net::HTTP.post(url, data, headers)
      response.body
    end
  end

  def cards(id)
    @xml = fetch(
      <<~XML
        <GeCards xmlns="http://web.cbr.ru/">
          <InternalCode>#{id}</InternalCode>
        </GeCards>
      XML
    )
    puts doc
    @data = find("//")
  end
end
