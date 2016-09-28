require 'spec_helper'

describe Arpa::Repositories::Actions::Finder, type: :repository, slow: true do

  let(:resource_record)   { create :repository_resource, :user }
  let(:action_record_001) { create :repository_action, :index, resource: resource_record }
  let(:action_record_002) { create :repository_action, :show, resource: resource_record}

  before do
    action_record_001
    action_record_002
  end

  describe '#by_name_and_resource' do

    context 'when exist with the params' do

      let(:result) { subject.by_name_and_resource('index', resource_record) }

      it 'should return a resource with name "index"' do
        expect(result.name).to eql 'index'
      end

      it 'the result should be an instance of Arpa::Entities::Action' do
        expect(result).to be_an Arpa::Entities::Action
      end
    end

    context 'when nonexist with the params' do

      let(:result) { subject.by_name_and_resource('nonexist_action', resource_record) }

      it 'the result should return nil' do
        expect(result).to be_nil
      end
    end

  end

  describe 'getting permission from action_name, resource_name and profile_ids' do
    let(:resource_name) { '' }
    let(:action_name)   { '' }
    let(:profile_ids)   { [] }

    let(:result) { subject.permission(resource_name, action_name, profile_ids) }

    before { result }

    context 'when action and resource belongs to some profile' do
      let(:user_resource) { create :repository_resource, :user }
      let(:index_action)  { create :repository_action, :index, resource: user_resource }
      let(:show_action)   { create :repository_action, :show, resource: user_resource }

      let(:user_resource_001) { create :repository_resource, :contact }
      let(:index_action_001)  { create :repository_action, :index, resource: user_resource }

      let(:role_001) { create :repository_role, actions: [index_action] }
      let(:role_002) { create :repository_role, actions: [index_action] }
      let(:role_003) { create :repository_role, actions: [index_action_001] }

      let(:profile_001) { create :repository_profile, roles: [role_001, role_002] }
      let(:profile_002) { create :repository_profile, roles: [role_001, role_003] }

      let(:resource_name) { 'users' }
      let(:action_name)   { 'index' }
      let(:profile_ids)   { [profile_001.id, profile_002.id] }

      it 'should return some permission' do
        expect(result).to be_an Arpa::Entities::Action
      end
    end

    context 'when action and resource not belogns to any profile' do

      it 'should not return any permission' do
        expect(result).to be_nil
      end
    end
  end

end
