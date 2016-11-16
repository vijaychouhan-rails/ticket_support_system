FactoryGirl.define do
  factory :comment do
    association :user
    association :ticket
    message { Faker::Lorem.paragraph }
  end
end
