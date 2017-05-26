FactoryGirl.define do
  factory :repository_profile, class: Arpa::Repositories::Profiles::RepositoryProfile do

    name        'some_profile'
    description 'description_profile'

    trait :with_complete_association do
      roles { [FactoryGirl.create(:repository_role, :with_complete_association)] }
    end

    trait :with_entity do
      entity_id { FactoryGirl.create(:entity) }
      entity_class { FactoryGirl.create(:entity).class.to_s }
    end
  end
end
