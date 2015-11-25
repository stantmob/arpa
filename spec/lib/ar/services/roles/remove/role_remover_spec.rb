require 'spec_helper'

describe Arpa::Services::Roles::Remove::RoleRemover, type: :service, fast: true do

  let(:role) { double }

  describe 'removing role' do
    let(:remover_repo_class) { Arpa::Repositories::Roles::Remover }
    let(:remover_repo)       { instance_double remover_repo_class }
    let(:setup)              {  }

    before do
      allow(remover_repo_class).to receive(:new).and_return(remover_repo)
      setup
      subject.remove(role)
    end

    context 'when role has no profiles' do

      let(:setup) do
        allow(role).to receive(:has_profile?).and_return(false)
        allow(remover_repo).to receive(:destroy)
      end

      it 'remover repository should call :destroy once' do
        expect(remover_repo).to have_received(:destroy).once
      end

      it 'remover repository should call :new once' do
        expect(remover_repo_class).to have_received(:new).once
      end

    end

    context 'when role has profiles' do

      let(:setup) do
        allow(role).to receive(:has_profile?).and_return(true)
        allow(remover_repo).to receive(:disable)
      end

      it 'remover repository should call :disable once' do
        expect(remover_repo).to have_received(:disable).once
      end

    end

  end

end
