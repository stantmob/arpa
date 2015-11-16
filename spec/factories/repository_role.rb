FactoryGirl.define do
  factory :repository_role, class: Ar::Repositories::Roles::RepositoryRole do

    name        'some_role'
    description 'description_role'

  end
end
