# frozen_string_literal: true

module Cbrf
  module Credit
    RSpec.describe Form::Dbf, :vcr do
      let(:code) { self.class.description }
      let(:date) { Date.new 2025, 1, 1 }

      subject { described_class.new(code) }
      let(:form) { subject.on(date) }
      let(:data) { form.data }
      let(:indicators) { form.indicators }
      let(:organizations) { form.organizations }

      describe "101" do
        it { expect(data).to be_a DBF::Table }
        it { expect(indicators).to be_a DBF::Table }
        it { expect(organizations).to be_a DBF::Table }

        context "unknown date" do
          let(:date) { Date.new 3000, 1, 1 }

          it { expect(data).to be_nil }
        end
      end
    end
  end
end
