FactoryGirl.define do
  factory :repository_profile, class: Ar::Repositories::Profiles::RepositoryProfile do

    name        'some_profile'
    description 'description_profile'

  end
end
