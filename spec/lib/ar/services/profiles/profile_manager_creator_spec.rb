require 'spec_helper'

describe Arpa::Services::Profiles::ProfileManagerCreator, type: :service, fast: true do

  let(:profile_creator) { double }
  let(:params)          { {profile: {name: 'profile_name', description: 'profile_description', role_ids: [1, 2]}} }
  let(:success_proc)    { ->(r) {} }
  let(:callback)        { {success: success_proc, fail: ->(e) {raise e} } }

  let(:setup_creators) do
    allow(Arpa::Services::Profiles::Create::ProfileCreator).to receive(:new).and_return(profile_creator)
  end

  let(:setup_creators_methods) do
    allow(profile_creator).to receive(:create)
  end

  let(:result) { subject.create params, callback }

  before do
    setup_creators
    setup_creators_methods
    allow(success_proc).to receive(:call)
    result
  end

  it 'profile_creator should call :create with parameters' do
    expect(profile_creator).to have_received(:create).with(params[:profile]).once
  end

end
