require 'spec_helper'

describe Ar::DataMappers::ActionMapper, type: :mapper, fast: true do
  let(:mapper) { Ar::DataMappers::ActionMapper.instance }

  describe 'mapping to record instance' do
    let(:entity)           { Ar::Entities::Action.new(name: 'index')}
    let(:repository_class) { Ar::Repositories::Actions::RepositoryAction }
    let(:record_instance)  { mapper.map_to_record(repository_class, entity) }

    it 'record_instance should be an instance of ActiveRecord::Base' do
      expect(record_instance).to be_a ActiveRecord::Base
    end

    it 'record_instance should fill the property :name from entity property' do
      expect(record_instance.name).to eql 'index'
    end
  end

  describe 'mapping to entity instance' do
    let(:entity)          { Ar::Entities::Action.new }
    let(:record)          { create :repository_action, :index }
    let(:entity_instance) { mapper.map_to_entity(record, entity) }

    it 'entity_instance should fill the property :name from record property' do
      expect(entity_instance.name).to eql 'index'
    end

    it 'entity_instance should fill the property :id from record property' do
      expect(entity_instance.id).to be == record.id
    end

    it 'entity_instance should fill the property :resource_id from record property' do
      expect(entity_instance.resource_id).to be == record.resource_id
    end

    it 'entity_instance should fill the property :resource from record property' do
      expect(entity_instance.resource).to eq record.resource
    end
  end

end
