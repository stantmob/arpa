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

  describe 'getting permissions from profile_ids' do
    let(:profile_001) { create :repository_profile, :with_complete_association, name: 'prof_001' }
    let(:profile_002) { create :repository_profile, :with_complete_association, name: 'prof_002' }
    let(:profile_ids) { [profile_001.id, profile_002.id] }

    let(:result) { subject.permissions(profile_ids) }
    let(:first)  { result.first }

    it 'should return an Arpa::Entities::Permissions' do
      expect(result).to be_an Arpa::Entities::Permissions
    end

    it 'should has just one permission' do
      expect(result.permissions.size).to be == 1
    end

  end
end
