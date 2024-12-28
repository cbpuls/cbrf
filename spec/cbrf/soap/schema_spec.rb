# frozen_string_literal: true

RSpec.describe Cbrf::Soap::Schema do
  let(:doc) { XML::Parser.file("../../fixtures/info.xml").parse }
  let(:xml_schema) { doc.find_first("//xs:schema", "xs:http://www.w3.org/2001/XMLSchema") }
  let(:xml_responce) { doc.find_first("//diffgr:diffgram", "diffgr:urn:schemas-microsoft-com:xml-diffgram-v1") }
  subject { described_class.new(xml_schema) }
end
