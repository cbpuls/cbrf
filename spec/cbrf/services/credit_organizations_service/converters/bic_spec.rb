require "spec_helper"

RSpec.describe Cbrf::Services::CreditOrganizationsService::Converterse::Bic do
  let(:sberbank) { { bic: "044525225", registration_no: "1481", internal_code: "350000004" } }
  subject { described_class.new(sberbank[:bic]) }

  %i[registration_no internal_code].each do |method|
    it "should return #{method}" do
      expect(subject.send(method)).to eq(sberbank[method])
    end
  end
end
