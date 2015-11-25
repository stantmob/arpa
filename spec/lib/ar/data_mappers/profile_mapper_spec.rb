require 'spec_helper'

describe Ar::DataMappers::ProfileMapper, type: :mapper, fast: true do
  let(:mapper) { Ar::DataMappers::ProfileMapper.instance }

  describe 'mapping to record instance' do
    let(:entity)           { Ar::Entities::Profile.new(name: 'some_profile')}
    let(:repository_class) { Ar::Repositories::Profiles::RepositoryProfile }
    let(:record_instance)  { mapper.map_to_record(repository_class, entity) }

    it 'record_instance should be an instance of Ar::Repositories::Profiles::RepositoryProfile' do
      expect(record_instance).to be_a Ar::Repositories::Profiles::RepositoryProfile
    end

    it 'record_instance should fill the property :name from entity property' do
      expect(record_instance.name).to eql 'some_profile'
    end
  end

  describe 'mapping to entity instance' do
    let(:action_record)   { create :repository_action, :index }
    let(:role_record)     { create :repository_role, action_ids: [action_record.id] }
    let(:record)          { create :repository_profile, role_ids: [role_record.id] }
    let(:entity_instance) { mapper.map_to_entity(record) }

    it 'entity_instance should fill the property :name from record property' do
      expect(entity_instance.name).to eql 'some_profile'
    end

    it 'entity_instance should fill the property :id from record property' do
      expect(entity_instance.id).to be == record.id
    end

    it 'entity_instance should fill the property :roles from record property' do
      expect(entity_instance.roles.first).to be_an Ar::Entities::Role
    end

    it 'entity_instance should fill the property :role_ids from record property' do
      expect(entity_instance.role_ids).to eq [role_record.id]
    end

  end

end
