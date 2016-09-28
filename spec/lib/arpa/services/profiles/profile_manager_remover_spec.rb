require 'spec_helper'

describe Arpa::Services::Profiles::ProfileManagerRemover, type: :service, fast: true do

  let(:profile_remover) { double }
  let(:profile)         { double }
  let(:success_proc)    { ->(r) {} }
  let(:callback)        { {success: success_proc, fail: ->(e) {raise e} } }

  let(:setup_updaters) do
    allow(Arpa::Services::Profiles::Remove::ProfileRemover).to receive(:new).and_return(profile_remover)
  end

  let(:setup_updaters_methods) do
    allow(profile_remover).to receive(:remove)
  end

  let(:result) { subject.remove params, callback }

  before do
    setup_updaters
    setup_updaters_methods
    allow(success_proc).to receive(:call)
    result
  end

  context 'when is to destroy' do
    let(:params) { {profile: profile} }

    it 'profile_remover should call :remove with profile as parameter' do
      expect(profile_remover).to have_received(:remove).with(profile, nil).once
    end
  end

  context 'when is to disable' do
    let(:params) { {profile: profile, disable: true} }

    it 'profile_remover should call :remove with profile and disable: true as parameter' do
      expect(profile_remover).to have_received(:remove).with(profile, true).once
    end

  end

end
