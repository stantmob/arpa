require 'spec_helper'

describe Arpa::Services::Verifier do
  let(:session) { {} }
  let(:current_user) { double profile_ids: [1,2,3] }

  subject(:verifier) { Arpa::Services::Verifier.new(session, current_user) }

  describe '#has_access?' do
    context 'when pass a free action which begin with "_"' do
      it 'should has access' do
        expect(subject.has_access?('home', '_some_action')).to be_truthy
      end
    end

    context 'when pass a non free action' do
      let(:resource_finder_class) { Arpa::Repositories::Resources::Finder }
      let(:resource_finder)       { instance_double resource_finder_class }
      let(:entity_permissions)    { double }

      before do
        allow(resource_finder_class).to receive(:new).and_return(resource_finder)
        allow(resource_finder).to receive(:permissions).with([1,2,3]).and_return(entity_permissions)
        allow(entity_permissions).to receive(:has_permission?).with('users', 'index')

        subject.has_access?('users', 'index')
      end

      it 'should be called :new from Arpa::Repositories::Resources::Finder' do
        expect(resource_finder_class).to have_received(:new).once
      end

      it 'should be called :permissions from Arpa::Repositories::Resources::Finder' do
        expect(resource_finder).to have_received(:permissions).with([1,2,3]).once
      end

      it 'should be called :has_permission? from session[:entity_permissions]' do
        expect(entity_permissions).to have_received(:has_permission?).with('users', 'index').once
      end

    end

  end
end
