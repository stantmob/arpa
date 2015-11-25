require 'spec_helper'

class TestMapper < Arpa::DataMappers::Base
  entity_class 'TestRepository'
  repository_class 'TestRepository'
  attributes_to_map :id, :name
end

describe Arpa::DataMappers::Base, type: :mapper, fast: true do
  let(:mapper) { TestMapper.instance }

  context 'when initialize more than one Mapper' do

    let(:mapper_002) { TestMapper.instance }

    it 'the instances should use singleton pattern' do
      expect(mapper).to eq mapper_002
    end
  end

  describe 'mapping to record instance' do
    let(:entity)           { double id: nil, name: 'Some Name' }
    let(:record_instance)  { mapper.map_to_record(entity) }

    it 'record_instance should be an instance of ActiveRecord::Base' do
      expect(record_instance).to be_a ActiveRecord::Base
    end

    it 'record_instance should fill the property :name from entity property' do
      expect(record_instance.name).to eql 'Some Name'
    end
  end

  describe 'mapping to entity instance' do
    let(:record)          { TestRepository.create(name: 'Name One') }
    let(:entity_instance) { mapper.map_to_entity(record) }

    it 'entity_instance should fill the property :name from record property' do
      expect(entity_instance.name).to eql 'Name One'
    end

    it 'entity_instance should fill the property :id from record property' do
      expect(entity_instance.id).to be == record.id
    end
  end

end
