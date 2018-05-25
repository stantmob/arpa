FactoryBot.define do
  factory :repository_action, class: Arpa::Repositories::Actions::RepositoryAction do

    trait :index do
      name 'index'
      resource { FactoryBot.create(:repository_resource, :user) }
    end

    trait :show do
      name 'show'
      resource { FactoryBot.create(:repository_resource, :user) }
    end

    trait :with_complete_association do
      name 'index_new'
      resource { FactoryBot.create(:repository_resource, :user) }
    end
  end
end
