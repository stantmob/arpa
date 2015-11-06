require 'spec_helper'

describe Ar::Validators::ResourceValidator do
  let(:resource) { double full_name: '', name: '' }

  subject { Ar::Validators::ResourceValidator.new resource }

  before { subject.valid? }

  context 'when require' do
    it { expect(subject.errors).to be_added(:full_name, :blank) }
    it { expect(subject.errors).to be_added(:name, :blank) }
  end

end
