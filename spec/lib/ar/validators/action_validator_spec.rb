require 'spec_helper'

describe Ar::Validators::ActionValidator do
  let(:action) { double name: '' }

  subject { Ar::Validators::ActionValidator.new action }

  before { subject.valid? }

  context 'when require' do
    it { expect(subject.errors).to be_added(:name, :blank) }
  end

end
