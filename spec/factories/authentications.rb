FactoryGirl.define do
  factory :authentication do
    association :user
    provider 'twitter'
    uid Faker::Number.number(8)
  end
end
