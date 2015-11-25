require 'spec_helper'

describe Arpa::Services::Resources::Remove::ResourceRemover, type: :service, fast: true do

  let(:resource_001) { double full_name: 'UsersController' }
  let(:resource_002) { double full_name: 'OldContactsController' }
  let(:resources)    { [resource_001, resource_002]}

  let(:resourceable_001) { double to_s: 'UsersController' }
  let(:resourceable_002) { double to_s: 'ContactsController' }
  let(:resourceables)    { [resourceable_001, resourceable_002]}

  describe 'removing nonexistent resources' do

    let(:finder_repo_class) { Arpa::Repositories::Resources::Finder }
    let(:finder_repo)       { instance_double finder_repo_class }

    let(:remover_repo_class) { Arpa::Repositories::Resources::Remover }
    let(:remover_repo)       { instance_double remover_repo_class }

    before do
      allow(finder_repo_class).to receive(:new).and_return(finder_repo)
      allow(finder_repo).to receive(:all).and_return(resources)

      allow(remover_repo_class).to receive(:new).and_return(remover_repo)
      allow(remover_repo).to receive(:destroy).with(resource_002)

      subject.remove_nonexistent_resources(resourceables)
    end

    it 'finder repository should call :new once' do
      expect(finder_repo_class).to have_received(:new).once
    end

    it 'remover repository should call :new once' do
      expect(remover_repo_class).to have_received(:new).once
    end

    it 'finder repository should call :all once' do
      expect(finder_repo).to have_received(:all).once
    end

    it 'remover repository should call :destroy once' do
      expect(remover_repo).to have_received(:destroy).once
      expect(remover_repo).to have_received(:destroy).with(resource_002).once
    end

  end

end
