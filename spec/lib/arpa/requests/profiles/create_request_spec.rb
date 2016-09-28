require 'spec_helper'

RSpec.describe "Create Profile", type: [:request, :profile] do
  let(:finder_profile_repo)      { Arpa::Repositories::Profiles::Finder.new }
  let(:finder_resource_repo)     { Arpa::Repositories::Resources::Finder.new }
  let(:finder_role_repo)         { Arpa::Repositories::Roles::Finder.new }
  let(:creator_resource_service) { Arpa::Services::Resources::ResourceManagerCreator.new }
  let(:creator_role_service)     { Arpa::Services::Roles::RoleManagerCreator.new }
  let(:creator_profile_service)  { Arpa::Services::Profiles::ProfileManagerCreator.new }
  let(:success_proc)             { ->(r) {} }
  let(:callback)                 { {success: success_proc, fail: ->(e) {raise e} } }

  context 'when have no created resources or actions' do
    let(:resourceable_001)  { double to_s: 'UsersController', action_methods: [:index, :show, 'edit'] }
    let(:resourceable_002)  { double to_s: 'ContactsController', action_methods: [:index, 'edit'] }
    let(:resourceables)     { [resourceable_001, resourceable_002] }
    let(:created_resources) { creator_resource_service.create({resourceables: resourceables}, callback) }

    let(:action_ids) { finder_resource_repo.all.first.actions.collect{ |action| action.id} }
    let(:role_001_params)   { {role: {name: 'role_name_001', description: 'role_description_001', action_ids: action_ids}} }
    let(:role_002_params)   { {role: {name: 'role_name_002', description: 'role_description_002', action_ids: action_ids}} }
    let(:created_roles) do
      creator_role_service.create(role_001_params, callback)
      creator_role_service.create(role_002_params, callback)
    end

    let(:role_ids) { finder_role_repo.all.map { |r| r.id } }

    before do
      created_resources
      created_roles
      profile_params = {profile: {name: 'profile_name', description: 'profile_description', role_ids: role_ids}}
      creator_profile_service.create(profile_params, callback)
    end

    it 'should be recorded one profile' do
      expect(finder_profile_repo.all.size).to be == 1
    end

    it 'should has 2 roles associated' do
      expect(finder_profile_repo.all.first.roles.size).to be == 2
    end

    context 'names of associated roles' do
      it {expect(finder_profile_repo.all.first.roles.first.name).to eql 'role_name_001'}
      it {expect(finder_profile_repo.all.first.roles.second.name).to eql 'role_name_002'}
    end

  end

end
