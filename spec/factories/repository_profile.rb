FactoryGirl.define do
  factory :repository_profile, class: Ar::Repositories::Profiles::RepositoryProfile do

    name        'some_profile'
    description 'description_profile'

    trait :with_complete_association do
      roles { [FactoryGirl.create(:repository_role, :with_complete_association)] }
    end
  end
end
