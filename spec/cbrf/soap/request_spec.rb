# frozen_string_literal: true

RSpec.describe Cbrf::Soap::Request do
  subject { described_class.new(name).with(args).to_xml }

  let(:name) { :LastUpdate }
  let(:args) { {} }

  it "should generate xml" do
    is_expected.to eq <<~XML
      <?xml version="1.0" encoding="UTF-8"?>
      <soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
        <soap12:Body>
          <LastUpdate xmlns="http://web.cbr.ru/"/>
        </soap12:Body>
      </soap12:Envelope>
    XML
  end

  describe "#with" do
    let(:name) { :BicToIntCode }
    let(:args) { { BicCode: "1234" } }

    it "must generate xml" do
      is_expected.to eq <<~XML
        <?xml version="1.0" encoding="UTF-8"?>
        <soap12:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
          <soap12:Body>
            <BicToIntCode xmlns="http://web.cbr.ru/">
              <BicCode>1234</BicCode>
            </BicToIntCode>
          </soap12:Body>
        </soap12:Envelope>
      XML
    end
  end
end
