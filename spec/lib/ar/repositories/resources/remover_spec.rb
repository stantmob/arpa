require 'spec_helper'

describe Arpa::Repositories::Resources::Remover, type: :repository, slow: true do

  let(:resource_001)     { create :repository_resource, :user }
  let(:destroy_resource) { subject.destroy(resource_001) }

  describe '#destroy' do

    context 'when resource has no actions associate' do
      let(:actions) { [] }

      it 'should destroy the resource' do
        expect { destroy_resource }.to change(Arpa::Repositories::Resources::RepositoryResource, :count).by(0)
      end
    end

    context 'when resource has actions associate' do
      let(:action_001) { create :repository_action, :index, resource: resource_001 }
      let(:action_002) { create :repository_action, :show,  resource: resource_001 }

      before do
        action_001
        action_002
      end

      it 'should destroy the resource' do
        expect { destroy_resource }.to change(Arpa::Repositories::Resources::RepositoryResource, :count).by(-1)
      end

      it 'should destroy all actions associate with resource' do
        expect { destroy_resource }.to change(Arpa::Repositories::Actions::RepositoryAction, :count).by(-2)
      end

    end

  end
end
