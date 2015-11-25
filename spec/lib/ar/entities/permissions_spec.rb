require 'spec_helper'

describe Arpa::Entities::Permissions, type: :presenter, fast: true do
  let(:index_action) { double name: 'index_new' }
  let(:resource_001) { double name: 'users', actions: [index_action] }
  let(:resource_002) { double name: 'users', actions: [index_action] }
  let(:resources)    { [resource_001, resource_002] }

  subject { Arpa::Entities::Permissions.new(resources)}

  describe 'intializing' do
    let(:result) { subject.permissions }

    it 'attr :permissions should be an Array' do
      expect(result).to be_an Array
    end

    it 'should fill attr :permissions as an Array of Hash with keys :resource and :action' do
      first = result.first

      expect(first).to be_a Hash
      expect(first.has_key?('resource')).to be_truthy
      expect(first.has_key?('action')).to be_truthy
    end

    context 'when try fill permissions with duplicate resource and action' do
      let(:hash_permission) { {'resource' => 'users', 'action' => 'index_new' } }

      it 'should has only one Hash with that duplicated resource and action' do
        duplicated_hash_permission = result.detect{ |e| result.count(e) > 1 }
        expect(duplicated_hash_permission).to be_nil
      end
    end

  end

  describe '#has_permission?' do
    let(:resource_name) { 'users' }
    let(:result) { subject.has_permission?(resource_name, action_name) }

    context 'when has' do
      let(:action_name) { 'index_new' }

      it 'should return true' do
        expect(result).to be_truthy
      end

    end

    context 'when has not' do
      let(:action_name) { 'index' }

      it 'should return false' do
        expect(result).to be_falsey
      end

    end
  end

end

