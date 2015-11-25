require 'spec_helper'

describe Arpa::Services::Profiles::ProfileManagerUpdater, type: :service, fast: true do

  let(:profile_updater) { double }
  let(:params)          { {profile: {name: 'profile_name', description: 'profile_description', role_ids: [1, 2]}} }
  let(:success_proc)    { ->(r) {} }
  let(:callback)        { {success: success_proc, fail: ->(e) {raise e} } }

  let(:setup_updaters) do
    allow(Arpa::Services::Profiles::Update::ProfileUpdater).to receive(:new).and_return(profile_updater)
  end

  let(:setup_updaters_methods) do
    allow(profile_updater).to receive(:update)
  end

  let(:result) { subject.update params, callback }

  before do
    setup_updaters
    setup_updaters_methods
    allow(success_proc).to receive(:call)
    result
  end

  it 'profile_updater should call :update with parameters' do
    expect(profile_updater).to have_received(:update).with(params[:profile]).once
  end

end
