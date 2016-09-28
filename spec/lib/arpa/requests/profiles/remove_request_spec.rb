require 'spec_helper'

RSpec.describe "Remove Profile", type: [:request, :profile] do
  let(:finder_profile_repo)     { Arpa::Repositories::Profiles::Finder.new }
  let(:remover_profile_service) { Arpa::Services::Profiles::ProfileManagerRemover.new }
  let(:success_proc)            { ->(r) {} }
  let(:callback)                { {success: success_proc, fail: ->(e) {raise e} } }

  describe 'removing a Profile' do

    before do
      create :repository_profile
      remover_profile_service.remove(profile_params_to_remove, callback)
    end

    context 'when need destroy a Profile' do
      let(:profile_params_to_remove) { {profile: finder_profile_repo.all.first } }

      it 'record should be removed ' do
        expect(finder_profile_repo.all.size).to be == 0
      end

    end

    context 'when need disable a Profile' do
      let(:profile_params_to_remove) { {profile: finder_profile_repo.all.first, disable: true } }

      it 'record should be removed ' do
        expect(finder_profile_repo.all.size).to be == 0
      end

    end

  end

end
