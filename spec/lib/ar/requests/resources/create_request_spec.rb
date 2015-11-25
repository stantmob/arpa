require 'spec_helper'

RSpec.describe "Create Resource", type: [:request, :resource] do
  let(:finder_repo)     { Arpa::Repositories::Resources::Finder.new }
  let(:creator_service) { Arpa::Services::Resources::ResourceManagerCreator.new }
  let(:success_proc)    { ->(r) {} }
  let(:callback)        { {success: success_proc, fail: ->(e) {raise e} } }

  context 'when have no created resources or actions' do
    let(:resourceable_001) { double to_s: 'UsersController', action_methods: [:index, :show, 'edit'] }
    let(:resourceable_002) { double to_s: 'ContactsController', action_methods: [:index, 'edit'] }
    let(:resourceables)    { [resourceable_001, resourceable_002] }

    before do
      creator_service.create({resourceables: resourceables}, callback)
    end

    it 'should be recorded two resources' do
      expect(finder_repo.all.size).to be == 2
    end

    context 'names of resources' do
      it {expect(finder_repo.all.first.name).to eql('contacts') }
      it {expect(finder_repo.all.second.name).to eql('users') }
    end

    context 'Contacts resource' do
      let(:contacts_resource) { finder_repo.all.first }

      it 'should has two actions' do
        expect(contacts_resource.actions.size).to be == 2
      end

      context 'names of actions' do
        it {expect(contacts_resource.actions.first.name).to eql('edit') }
        it {expect(contacts_resource.actions.second.name).to eql('index') }
      end
    end

    context 'Users resource' do
      let(:users_resource) { finder_repo.all.second }

      it 'should has three actions' do
        expect(users_resource.actions.size).to be == 3
      end

      context 'names of actions' do
        it {expect(users_resource.actions.first.name).to eql('edit') }
        it {expect(users_resource.actions.second.name).to eql('index') }
        it {expect(users_resource.actions.third.name).to eql('show') }
      end

    end
  end

  context 'when have created resources or actions' do
    let(:resourceable_001)      { double to_s: 'UsersController', action_methods: [:index, :show, 'edit'] }
    let(:resourceable_002)      { double to_s: 'ContactsController', action_methods: [:index, 'edit'] }
    let(:created_resourceables) { [resourceable_001, resourceable_002] }

    let(:resourceable_003)  { double to_s: 'Arpa::NewUsersController', action_methods: [:show, 'edit'] }
    let(:resourceable_004)  { double to_s: 'ContactsController', action_methods: [:index, 'new_edit'] }
    let(:new_resourceables) { [resourceable_003, resourceable_004] }

    before do
      creator_service.create({resourceables: created_resourceables}, callback)
      creator_service.create({resourceables: new_resourceables}, callback)
    end

    it 'should be recorded two resources' do
      expect(finder_repo.all.size).to be == 2
    end

    context 'names of resources' do
      it {expect(finder_repo.all.first.name).to eql('arpa/new_users') }
      it {expect(finder_repo.all.second.name).to eql('contacts') }
    end

    context 'Contacts resource' do
      let(:contacts_resource) { finder_repo.all.second }

      it 'should has two actions' do
        expect(contacts_resource.actions.size).to be == 2
      end

      context 'names of actions' do
        it {expect(contacts_resource.actions.first.name).to eql('index') }
        it {expect(contacts_resource.actions.second.name).to eql('new_edit') }
      end
    end

    context 'Arpa::NewUsers resource' do
      let(:users_resource) { finder_repo.all.first }

      it 'should has two actions' do
        expect(users_resource.actions.size).to be == 2
      end

      context 'names of actions' do
        it {expect(users_resource.actions.first.name).to eql('edit') }
        it {expect(users_resource.actions.second.name).to eql('show') }
      end

    end
  end

end
