FactoryGirl.define do
  factory :ticket do
    association :user
    subject { Faker::Lorem.sentence }
    message { Faker::Lorem.paragraph }
  end
end
