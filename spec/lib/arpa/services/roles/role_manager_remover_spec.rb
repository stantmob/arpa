require 'spec_helper'

describe Arpa::Services::Roles::RoleManagerRemover, type: :service, fast: true do

  let(:role_remover) { double }
  let(:role)         { double }
  let(:params)       { {role: role} }
  let(:success_proc) { ->(r) {} }
  let(:callback)     { {success: success_proc, fail: ->(e) {raise e} } }

  let(:setup_updaters) do
    allow(Arpa::Services::Roles::Remove::RoleRemover).to receive(:new).and_return(role_remover)
  end

  let(:setup_updaters_methods) do
    allow(role_remover).to receive(:remove)
  end

  let(:result) { subject.remove params, callback }

  before do
    setup_updaters
    setup_updaters_methods
    allow(success_proc).to receive(:call)
    result
  end

  it 'role_remover should call :remove with role as parameter' do
    expect(role_remover).to have_received(:remove).with(role).once
  end

end
