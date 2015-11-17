require 'spec_helper'

describe Ar::Repositories::Roles::Finder, type: :repository, slow: true do

  let(:record_001) { create :repository_role, name: 'role_01' }
  let(:record_002) { create :repository_role, name: 'role_02' }

  before do
    record_001
    record_002
  end

  describe '#find' do
    let(:result) { subject.find(record_001.id) }

    it 'the Role entity should has name "role_01"' do
      expect(result.name).to eql 'role_01'
    end

    it 'the result should be an Ar::Entities::Role' do
      expect(result).to be_an Ar::Entities::Role
    end

  end

  describe '#all' do
    let(:result) { subject.all }

    it 'should return size 2' do
      expect(result.size).to be == 2
    end

    it 'the first Role entity should has name "role_01"' do
      expect(result.first.name).to eql 'role_01'
    end

    it 'the result should be an Array of Ar::Entities::Role' do
      expect(result.first).to be_an Ar::Entities::Role
    end

  end

end
