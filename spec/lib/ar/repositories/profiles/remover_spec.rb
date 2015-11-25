require 'spec_helper'

describe Arpa::Repositories::Profiles::Remover, type: :repository, slow: true do

  let(:created_profile) { create :repository_profile }

  before { created_profile }

  describe '#destroy' do
    let(:destroy_profile) { subject.destroy(created_profile) }

    it 'should destroy the role' do
      expect { destroy_profile }.to change(Arpa::Repositories::Profiles::RepositoryProfile, :count).by(-1)
    end

  end

  describe '#disable' do
    let(:disable_profile) { subject.disable(created_profile) }

    it 'should disable the role' do
      expect { disable_profile }.to change(Arpa::Repositories::Profiles::RepositoryProfile, :count).by(-1)
    end

    it 'role should be setted to removed: true' do
      expect(disable_profile.removed).to be_truthy
    end

  end

end
