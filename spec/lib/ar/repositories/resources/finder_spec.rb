require 'spec_helper'

describe Ar::Repositories::Resources::Finder, type: :repository, slow: true do

  let(:record_001) { create :repository_resource, :user }
  let(:record_002) { create :repository_resource, :contact }
  let(:result)     { subject.all }

  before do
    record_001
    record_002
  end

  describe '#all' do

    it 'should return size 2' do
      expect(result.size).to be == 2
    end

    it 'the first Resource entity should has full_name "UsersController"' do
      expect(result.first.full_name).to eql 'UsersController'
    end

    it 'the result should be an Array of Ar::Entities::Resource' do
      expect(result.firs).to be_an Ar::Entities::Resource
    end

  end
end
