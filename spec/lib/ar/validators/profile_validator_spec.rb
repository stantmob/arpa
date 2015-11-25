require 'spec_helper'

describe Arpa::Validators::ProfileValidator, type: :validator, fast: true do
  let(:profile) { double name: '', description: '', role_ids: [] }

  subject { Arpa::Validators::ProfileValidator.new profile }

  before { subject.valid? }

  context 'when require' do
    it { expect(subject.errors).to be_added(:name, :blank) }
    it { expect(subject.errors).to be_added(:description, :blank) }
    it { expect(subject.errors).to be_added(:role_ids, :many_blank) }
  end

end
