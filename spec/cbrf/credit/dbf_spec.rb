# frozen_string_literal: true

module Cbrf
  module Credit
    RSpec.describe Form::Dbf, :vcr do
      let(:code) { self.class.description }
      let(:date) { Date.new 2025, 1, 1 }

      subject { described_class.new(code, date) }
      let(:data) { subject.data }

      describe "101" do
        it { expect(subject.rar_url).to eq "https://www.cbr.ru/vfs/credit/forms/101-20250101.rar" }
        # it { expect(subject.rar).not_to be_empty }
        it { expect(data).to eq 1 }
      end
    end
  end
end
