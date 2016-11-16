FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password 'Testpass!'

    trait :admin do
      user_type 'admin'
    end

    trait :customer do
      user_type 'customer'
    end

    trait :agent do
      user_type 'agent'
    end
  end
end
