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

    it 'should return all' do
      expect(result.size).to be == 2
    end

    it 'the first Profile entity should has name "profile_01"' do
      expect(result.first.name).to eql 'profile_01'
    end

    it 'the result should be an Array of Arpa::Entities::Profile' do
      expect(result.first).to be_an Arpa::Entities::Profile
    end

  end

  describe '#all_by_entity' do

    context 'when have profiles with differents entities' do
      let(:entity_001) { create :entity }
      let(:record_003) { create :repository_profile, name: 'profile_03', entity_id: entity_001.id, entity_class: entity_001.class }
      let(:record_004) { create :repository_profile, :with_entity, name: 'profile_04' }
      let(:result) { subject.all_by_entity entity_001.id, entity_001.class.to_s }

      before do
        record_003
        record_004
      end

      it 'should return all without entity and with correct entity' do
        expect(result.size).to be == 3
      end

      it 'the result without entity should fill with nil value' do
        first = result.first
        expect(first.entity_id).to be_nil
        expect(first.entity_class).to be_nil

        second = result.second
        expect(second.entity_id).to be_nil
        expect(second.entity_class).to be_nil
      end

      it 'the result with entity should be filled correct values' do
        third = result.third
        expect(third.entity_id).to be == entity_001.id
        expect(third.entity_class).to eql entity_001.class.to_s
      end

    end
  end

end
