require 'spec_helper'

describe Arpa::Repositories::Profiles::Finder, type: :repository, slow: true do

  let(:record_001) { create :repository_profile, name: 'profile_01' }
  let(:record_002) { create :repository_profile, name: 'profile_02' }

  before do
    record_001
    record_002
  end

  describe '#find' do
    let(:result) { subject.find(record_001.id) }

    it 'the Profile entity should has name "profile_01"' do
      expect(result.name).to eql 'profile_01'
    end

    it 'the result should be an Arpa::Entities::Profile' do
      expect(result).to be_an Arpa::Entities::Profile
    end

  end

  describe '#all' do
    let(:result) { subject.all }

    it 'should return size 2' do
      expect(result.size).to be == 2
    end

    it 'the first Profile entity should has name "profile_01"' do
      expect(result.first.name).to eql 'profile_01'
    end

    it 'the result should be an Array of Arpa::Entities::Profile' do
      expect(result.first).to be_an Arpa::Entities::Profile
    end

  end

end
