require 'spec_helper'

describe Arpa::Services::Actions::Remove::ActionRemover, type: :service, fast: true do

  let(:action_001) { double name: 'index' }
  let(:action_002) { double name: 'old_index' }
  let(:actions)    { [action_001, action_002]}
  let(:resource)   { double actions: actions }

  let(:actions_names) { ['index', 'show'] }

  let(:params) { {resource: resource, actions_names: actions_names} }

  describe 'removing nonexistent actions' do
    let(:remover_repo_class) { Arpa::Repositories::Actions::Remover }
    let(:remover_repo)       { instance_double remover_repo_class }

    before do
      allow(remover_repo_class).to receive(:new).and_return(remover_repo)
      allow(remover_repo).to receive(:destroy)

      subject.remove_nonexistent_actions(params)
    end

    it 'remover repository should call :new once' do
      expect(remover_repo_class).to have_received(:new).once
    end

    it 'remover repository should call :destroy once' do
      expect(remover_repo).to have_received(:destroy).once
      expect(remover_repo).to have_received(:destroy).with(action_002).once
    end

  end

end
