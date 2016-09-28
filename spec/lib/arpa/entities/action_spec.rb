require 'spec_helper'

describe Arpa::Entities::Action, type: :entity, fast: true do
  subject { Arpa::Entities::Action.new resource: resource, name: 'index'}

  describe 'getting description by action name and resource name' do
    before do
      I18n.backend.store_translations(:en, entities: { resources: { users: { actions: { description: { index: 'List of Users' } } } } } )
    end

    context 'when resource.name is "users" and action.name is "index"' do
      let(:resource) { double(name: 'users') }

      it 'description should be "List of Users"' do
        expect(subject.description).to eql "List of Users"
      end
    end
  end

  describe 'getting the resource name' do

    context 'when resource is not nil' do
      let(:resource) { double(name: 'users') }

      it 'resource name should be the same of the attribute' do
        expect(subject.resource_name).to eql 'users'
      end
    end

    context 'when resource is nil' do
      let(:resource) { nil }
      it 'resource name should be empty' do
        expect(subject.resource_name).to be_empty
      end
    end

  end

end
