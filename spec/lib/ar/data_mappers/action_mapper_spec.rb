require 'spec_helper'

describe Arpa::DataMappers::ActionMapper, type: :mapper, fast: true do
  let(:mapper) { Arpa::DataMappers::ActionMapper.instance }

  describe 'mapping to record instance' do
    let(:entity)          { Arpa::Entities::Action.new(name: 'index', resource_id: 1)}
    let(:record_instance) { mapper.map_to_record(entity) }

    it 'record_instance should be an instance of ActiveRecord::Base' do
      expect(record_instance).to be_a ActiveRecord::Base
    end

    it 'record_instance should fill the property :name from entity property' do
      expect(record_instance.name).to eql 'index'
    end

    it 'record_instance should fill the property :resource_id and :repository_resource_id from entity property' do
      expect(record_instance.resource_id).to be == 1
      expect(record_instance.repository_resource_id).to be == 1
    end

  end

  describe 'mapping to entity instance' do
    let(:record)          { create :repository_action, :index }
    let(:entity_instance) { mapper.map_to_entity(record) }

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
      expect(entity_instance.resource).to be_an Arpa::Entities::Resource
    end
  end

end
