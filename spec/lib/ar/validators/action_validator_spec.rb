require 'spec_helper'

describe Ar::Validators::ActionValidator, type: :validator, fast: true do
  let(:action) { double name: '', resource_id: nil }

  subject { Ar::Validators::ActionValidator.new action }

  before { subject.valid? }

  context 'when require' do
    it { expect(subject.errors).to be_added(:name, :blank) }
    it { expect(subject.errors).to be_added(:resource_id, :blank) }
  end

end
