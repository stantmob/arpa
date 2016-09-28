require 'spec_helper'

describe Arpa::Repositories::Roles::Remover, type: :repository, slow: true do

  let(:created_role) { create :repository_role }

  before { created_role }

  describe '#destroy' do
    let(:destroy_role) { subject.destroy(created_role) }

    it 'should destroy the role' do
      expect { destroy_role }.to change(Arpa::Repositories::Roles::RepositoryRole, :count).by(-1)
    end

  end

  describe '#disable' do
    let(:disable_role) { subject.disable(created_role) }

    it 'should disable the role' do
      expect { disable_role }.to change(Arpa::Repositories::Roles::RepositoryRole, :count).by(-1)
    end

    it 'role should be setted to removed: true' do
      expect(disable_role.removed).to be_truthy
    end

  end

end
