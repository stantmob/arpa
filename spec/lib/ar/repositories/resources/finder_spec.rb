require 'spec_helper'

describe Arpa::Repositories::Resources::Finder, type: :repository, slow: true do

  let(:record_001) { create :repository_resource, :user }
  let(:record_002) { create :repository_resource, :contact }

  describe '#find' do
    let(:result) { subject.find(record_001.id) }

    it 'the Resource entity should has name "users"' do
      expect(result.name).to eql 'users'
    end

    it 'the result should be an Arpa::Entities::Resource' do
      expect(result).to be_an Arpa::Entities::Resource
    end

  end

  describe '#all' do
    let(:result) { subject.all }

    before do
      record_001
      record_002
    end


    it 'should return size 2' do
      expect(result.size).to be == 2
    end

    it 'the first Resource entity should has full_name "ContactsController"' do
      expect(result.first.full_name).to eql 'ContactsController'
    end

    it 'the result should be an Array of Arpa::Entities::Resource' do
      expect(result.first).to be_an Arpa::Entities::Resource
    end

  end

  describe '#by_full_name' do

    before do
      record_001
      record_002
    end

    context 'when exist with the full_name' do

      let(:result) { subject.by_full_name('UsersController') }

      it 'should return a resource with name "users"' do
        expect(result.name).to eql 'users'
      end

      it 'the result should be an instance of Arpa::Entities::Resource' do
        expect(result).to be_an Arpa::Entities::Resource
      end
    end

    context 'when nonexist with the full_name' do

      let(:result) { subject.by_full_name('NonessController') }

      it 'the result should return nil' do
        expect(result).to be_nil
      end
    end

  end
end
