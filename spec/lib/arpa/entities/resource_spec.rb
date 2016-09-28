require 'spec_helper'

describe Arpa::Entities::Resource, type: :entity, fast: true do

  describe 'initializing' do

    describe 'setting default values' do

      context 'when pass :actions as nil' do

        it 'attribute :actions should be an empty Array' do
          expect(subject.actions).to eq []
        end
      end
    end

    context 'when pass :actions as empty' do
      let(:attrs) { {actions: ''} }
      subject { Arpa::Entities::Resource.new attrs }

      it 'attribute :actions should be an empty Array' do
        expect(subject.actions).to eq []
      end
    end

  end

  describe '#build_correct_name' do

    before { subject.build_correct_name }

    context 'when pass :full_name as "UsersController"' do
      subject { Arpa::Entities::Resource.new full_name: 'UsersController' }

      it 'full_name should be "UsersController"' do
        expect(subject.full_name).to eql 'UsersController'
      end

      it 'name should be builded as "users"' do
        expect(subject.name).to eql 'users'
      end
    end

    context 'when pass :full_name as "Authentication::Someone::UsersController"' do
      subject { Arpa::Entities::Resource.new full_name: 'Authentication::Someone::UsersController' }

      it 'full_name should be "Authentication::Someone::UsersController"' do
        expect(subject.full_name).to eql 'Authentication::Someone::UsersController'
      end

      it 'name should be builded as "authentication/someone/users"' do
        expect(subject.name).to eql 'authentication/someone/users'
      end
    end

  end

end
