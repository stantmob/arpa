require 'spec_helper'

describe Arpa::Services::Roles::RoleManagerCreator, type: :service, fast: true do

  let(:role_creator) { double }
  let(:params)           { {role: {name: 'role_name', description: 'role_description', action_ids: [1, 2]}} }
  let(:success_proc)     { ->(r) {} }
  let(:callback)         { {success: success_proc, fail: ->(e) {raise e} } }

  let(:setup_creators) do
    allow(Arpa::Services::Roles::Create::RoleCreator).to receive(:new).and_return(role_creator)
  end

  let(:setup_creators_methods) do
    allow(role_creator).to receive(:create)
  end

  let(:result) { subject.create params, callback }

  before do
    setup_creators
    setup_creators_methods
    allow(success_proc).to receive(:call)
    result
  end

  it 'role_creator should call :create with parameters' do
    expect(role_creator).to have_received(:create).with(params[:role]).once
  end

end
