require 'spec_helper'

describe Arpa::Entities::Profile, type: :entity, fast: true do

  describe 'initializing' do

    describe 'setting default values' do

      context 'when pass some parameters as nil' do

        it 'attribute :role_ids should be an empty Array' do
          expect(subject.role_ids).to eq []
        end

        it 'attribute :role should be an empty Array' do
          expect(subject.roles).to eq []
        end

        it 'attribute :removed should be false' do
          expect(subject.removed).to be_falsey
        end
      end
    end

    context 'when pass some parameters as empty' do
      let(:attrs) { {role_ids: '', roles: '', removed: ''} }
      subject { Arpa::Entities::Profile.new attrs }

      it 'attribute :role_ids should be an empty Array' do
        expect(subject.role_ids).to eq []
      end

      it 'attribute :role should be an empty Array' do
        expect(subject.roles).to eq []
      end

      it 'attribute :removed should be false' do
        expect(subject.removed).to be_falsey
      end
    end

  end

end
