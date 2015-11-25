require 'spec_helper'

RSpec.describe "Update Role", type: [:request, :role] do
  let(:finder_role_repo)         { Arpa::Repositories::Roles::Finder.new }
  let(:finder_resource_repo)     { Arpa::Repositories::Resources::Finder.new }
  let(:creator_resource_service) { Arpa::Services::Resources::ResourceManagerCreator.new }
  let(:creator_role_service)     { Arpa::Services::Roles::RoleManagerCreator.new }
  let(:updater_role_service)     { Arpa::Services::Roles::RoleManagerUpdater.new }
  let(:success_proc)             { ->(r) {} }
  let(:callback)                 { {success: success_proc, fail: ->(e) {raise e} } }

  context 'updating a Role' do
    let(:resourceable_001)  { double to_s: 'UsersController', action_methods: [:index, :show, 'edit'] }
    let(:resourceable_002)  { double to_s: 'ContactsController', action_methods: [:index, 'edit'] }
    let(:resourceables)     { [resourceable_001, resourceable_002] }
    let(:created_resources) { creator_resource_service.create({resourceables: resourceables}, callback) }
    let(:action_ids) { finder_resource_repo.all.first.actions.collect {|action| action.id} }

    let(:create_resources_and_role) do
      created_resources
      role_params = {role: {name: 'role_name', description: 'role_description', action_ids: action_ids}}
      creator_role_service.create(role_params, callback)
    end

    before do
      create_resources_and_role
      found_role = finder_role_repo.all.first
      role_params_to_update = {role: {id: found_role.id, name: 'updated_role_name', description: 'role_description', action_ids: [action_ids[0]] }}
      updater_role_service.update(role_params_to_update, callback)
    end

    it 'should be recorded one role' do
      expect(finder_role_repo.all.size).to be == 1
    end

    it 'should has 1 actions associated' do
      expect(finder_role_repo.all.first.actions.size).to be == 1
    end

    it 'name should be "updated_role_name"' do
      expect(finder_role_repo.all.first.name).to eql 'updated_role_name'
    end

    context 'names of associated actions' do
      it {expect(finder_role_repo.all.first.actions.first.name).to eql 'edit'}
    end

  end

end
