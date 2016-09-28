require 'spec_helper'

describe Arpa::Services::Profiles::Remove::ProfileRemover, type: :service, fast: true do

  let(:profile) { double }

  describe 'removing profile' do
    let(:remover_repo_class) { Arpa::Repositories::Profiles::Remover }
    let(:remover_repo)       { instance_double remover_repo_class }

    before do
      allow(remover_repo_class).to receive(:new).and_return(remover_repo)
      setup
      subject.remove(profile, disable)
    end

    context 'when pass nil as disable param' do
      let(:disable) { nil }

      let(:setup) { allow(remover_repo).to receive(:destroy) }

      it 'remover repository should call :destroy once' do
        expect(remover_repo).to have_received(:destroy).once
      end

      it 'remover repository should call :new once' do
        expect(remover_repo_class).to have_received(:new).once
      end

    end

    context 'when pass true as disable param' do
      let(:disable) { true }

      let(:setup) { allow(remover_repo).to receive(:disable) }

      it 'remover repository should call :disable once' do
        expect(remover_repo).to have_received(:disable).once
      end

    end

  end

end
