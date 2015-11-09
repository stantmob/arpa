require 'spec_helper'

describe Ar::Validators::RoleValidator, type: :validator, fast: true do
  let(:role) { double name: '', description: '' }

  subject { Ar::Validators::RoleValidator.new role }

  before { subject.valid? }

  context 'when require' do
    it { expect(subject.errors).to be_added(:name, :blank) }
    it { expect(subject.errors).to be_added(:description, :blank) }
  end

end
