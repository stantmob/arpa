require 'spec_helper'

describe Ar::Entities::Action do
  let(:resource) { double(name: 'users') }

  subject { Ar::Entities::Action.new resource: resource, name: 'index'}

  describe 'getting description by action name and resource name' do

    context 'when resource.name is "users" and action.name is "index"' do

      it 'description should be "List of users"' do
        expect(subject.description).to eql "List of users"
      end
    end

  end

end
