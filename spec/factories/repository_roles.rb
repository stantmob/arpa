FactoryGirl.define do
  factory :repository_role, class: Arpa::Repositories::Roles::RepositoryRole do

    name        'some_role'
    description 'description_role'

    trait :with_complete_association do
      actions {[FactoryGirl.create(:repository_action, :with_complete_association)] }
    end
  end
end
