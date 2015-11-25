require 'spec_helper'

describe Arpa::DataMappers::ResourceMapper, type: :mapper, fast: true do
  let(:mapper) { Arpa::DataMappers::ResourceMapper.instance }

  describe 'mapping to record instance' do
    let(:entity)          { Arpa::Entities::Resource.new(full_name: 'UsersController')}
    let(:record_instance) { mapper.map_to_record(entity) }

    it 'record_instance should be an instance of ActiveRecord::Base' do
      expect(record_instance).to be_a ActiveRecord::Base
    end

    it 'record_instance should fill the property :name from entity property' do
      expect(record_instance.full_name).to eql 'UsersController'
    end
  end

  describe 'mapping to entity instance' do
    let(:action_record)   { create :repository_action, :index }
    let(:record)          { create :repository_resource, :user, actions: [action_record] }
    let(:entity_instance) { mapper.map_to_entity(record.reload) }

    it 'entity_instance should fill the property :name from record property' do
      expect(entity_instance.full_name).to eql 'UsersController'
    end

    it 'entity_instance should fill the property :id from record property' do
      expect(entity_instance.id).to be == record.id
    end

    it 'entity_instance should fill the property :actions from record property' do
      expect(entity_instance.actions.first).to be_an Arpa::Entities::Action
    end

  end

end
