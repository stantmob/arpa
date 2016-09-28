require 'spec_helper'

describe Arpa::Entities::Role, type: :entity, fast: true do

  describe 'initializing' do

    describe 'setting default values' do

      context 'when pass some parameters as nil' do

        it 'attribute :action_ids should be an empty Array' do
          expect(subject.action_ids).to eq []
        end

        it 'attribute :actions should be an empty Array' do
          expect(subject.actions).to eq []
        end

        it 'attribute :profiles should be an empty Array' do
          expect(subject.profiles).to eq []
        end

        it 'attribute :removed should be false' do
          expect(subject.removed).to be_falsey
        end
      end
    end

    context 'when pass some parameters as empty' do
      let(:attrs) { {action_ids: '', actions: '', profiles: '', removed: ''} }
      subject { Arpa::Entities::Role.new attrs }

      it 'attribute :action_ids should be an empty Array' do
        expect(subject.action_ids).to eq []
      end

      it 'attribute :actions should be an empty Array' do
        expect(subject.actions).to eq []
      end

      it 'attribute :profiles should be an empty Array' do
        expect(subject.profiles).to eq []
      end

      it 'attribute :removed should be false' do
        expect(subject.removed).to be_falsey
      end
    end

  end

end
