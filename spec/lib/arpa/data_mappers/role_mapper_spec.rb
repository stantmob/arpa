require 'spec_helper'

describe Arpa::DataMappers::RoleMapper, type: :mapper, fast: true do
  let(:mapper) { Arpa::DataMappers::RoleMapper.instance }

  describe 'mapping to record instance' do
    let(:entity)          { Arpa::Entities::Role.new(name: 'some_role')}
    let(:record_instance) { mapper.map_to_record(entity) }

    it 'record_instance should be an instance of Arpa::Repositories::Roles::RepositoryRole' do
      expect(record_instance).to be_a Arpa::Repositories::Roles::RepositoryRole
    end

    it 'record_instance should fill the property :name from entity property' do
      expect(record_instance.name).to eql 'some_role'
    end
  end

  describe 'mapping to entity instance' do
    let(:action_record)   { create :repository_action, :index }
    let(:profile_record)  { create :repository_profile }
    let(:record)          { create :repository_role, profile_ids: [profile_record.id], action_ids: [action_record.id] }
    let(:entity_instance) { mapper.map_to_entity(record) }

    it 'entity_instance should fill the property :name from record property' do
      expect(entity_instance.name).to eql 'some_role'
    end

    it 'entity_instance should fill the property :id from record property' do
      expect(entity_instance.id).to be == record.id
    end

    it 'entity_instance should fill the property :actions from record property' do
      expect(entity_instance.actions.first).to be_an Arpa::Entities::Action
    end

    it 'entity_instance should fill the property :action_ids from record property' do
      expect(entity_instance.action_ids).to eq [action_record.id]
    end

    it 'entity_instance should fill the property :profiles from record property' do
      expect(entity_instance.profiles.first).to be_an Arpa::Entities::Profile
    end

  end

end
