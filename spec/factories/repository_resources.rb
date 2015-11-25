FactoryGirl.define do
  factory :repository_resource, class: Arpa::Repositories::Resources::RepositoryResource do

    trait :user do
      full_name 'UsersController'
      name      'users'
    end

    trait :contact do
      full_name 'ContactsController'
      name      'contacts'
    end

  end
end
