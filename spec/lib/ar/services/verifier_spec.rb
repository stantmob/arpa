require 'spec_helper'

describe Arpa::Services::Verifier do
  let(:session) { {} }
  let(:current_user) { double is_arpa_admin?: false, profile_ids: [1,2,3] }

  subject(:verifier) { Arpa::Services::Verifier.new(session, current_user) }

  describe 'cleaning session of permissions' do
    let(:session) { {entity_permissions: [ {'resource': 'users', 'action': 'index'} ] } }

    before { verifier.reset_permissions }

    it 'session[:entity_permissions] should be set to nil' do
      expect(session[:entity_permissions]).to be_nil
    end
  end

  describe '#has_access?' do

    context 'when current_user is a arpa admin' do
      let(:current_user) { double is_arpa_admin?: true, profile_ids: [1,2,3] }

      it 'should has access' do
        expect(subject.has_access?('home', 'some_action')).to be_truthy
      end
    end

    context 'when pass a free action which begin with "_"' do
      it 'should has access' do
        expect(subject.has_access?('home', '_some_action')).to be_truthy
      end
    end

    context 'when pass a non free action' do
      let(:action_finder_class) { Arpa::Repositories::Actions::Finder }
      let(:action_finder)       { instance_double action_finder_class }
      let(:entity_permissions)  { double }

      before do
        allow(action_finder_class).to receive(:new).and_return(action_finder)
        allow(action_finder).to receive(:permissions).with([1,2,3]).and_return(entity_permissions)
        allow(entity_permissions).to receive(:has_permission?).with('users', 'index')

        subject.has_access?('users', 'index')
      end

      it 'should be called :new from Arpa::Repositories::Actions::Finder' do
        expect(action_finder_class).to have_received(:new).once
      end

      it 'should be called :permissions from Arpa::Repositories::Actions::Finder' do
        expect(action_finder).to have_received(:permissions).with([1,2,3]).once
      end

      it 'should be called :has_permission? from session[:entity_permissions]' do
        expect(entity_permissions).to have_received(:has_permission?).with('users', 'index').once
      end

    end

  end
end
