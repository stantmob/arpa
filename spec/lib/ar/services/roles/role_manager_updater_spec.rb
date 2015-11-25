require 'spec_helper'

describe Arpa::Services::Roles::RoleManagerUpdater, type: :service, fast: true do

  let(:role_updater) { double }
  let(:params)       { {role: {name: 'role_name', description: 'role_description', action_ids: [1, 2]}} }
  let(:success_proc) { ->(r) {} }
  let(:callback)     { {success: success_proc, fail: ->(e) {raise e} } }

  let(:setup_updaters) do
    allow(Arpa::Services::Roles::Update::RoleUpdater).to receive(:new).and_return(role_updater)
  end

  let(:setup_updaters_methods) do
    allow(role_updater).to receive(:update)
  end

  let(:result) { subject.update params, callback }

  before do
    setup_updaters
    setup_updaters_methods
    allow(success_proc).to receive(:call)
    result
  end

  it 'role_updater should call :update with parameters' do
    expect(role_updater).to have_received(:update).with(params[:role]).once
  end

end
