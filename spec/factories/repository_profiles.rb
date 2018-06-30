FactoryBot.define do
  factory :repository_profile, class: Arpa::Repositories::Profiles::RepositoryProfile do
    name        'some_profile'
    description 'description_profile'

    trait :with_complete_association do
      roles { [FactoryBot.create(:repository_role, :with_complete_association)] }
    end

    trait :with_entity do
      entity_id { FactoryBot.create(:entity) }
      entity_class { FactoryBot.create(:entity).class.to_s }
    end
  end
end
