require 'spec_helper'

describe Ar::Validators::ProfileValidator, type: :validator, fast: true do
  let(:profile) { double name: '', description: '' }

  subject { Ar::Validators::ProfileValidator.new profile }

  before { subject.valid? }

  context 'when require' do
    it { expect(subject.errors).to be_added(:name, :blank) }
    it { expect(subject.errors).to be_added(:description, :blank) }
  end

end
