require 'spec_helper'

RSpec.describe "Remove Role", type: [:request, :role] do
  let(:finder_role_repo)     { Arpa::Repositories::Roles::Finder.new }
  let(:remover_role_service) { Arpa::Services::Roles::RoleManagerRemover.new }
  let(:success_proc)         { ->(r) {} }
  let(:callback)             { {success: success_proc, fail: ->(e) {raise e} } }

  describe 'removing a Role' do

    before do
      create :repository_role
      role_params_to_remove = {role: finder_role_repo.all.first }
      remover_role_service.remove(role_params_to_remove, callback)
    end

    it 'record should be removed ' do
      expect(finder_role_repo.all.size).to be == 0
    end

  end

end
