require 'faker'

FactoryGirl.define do
  factory :challenge do
    association :user
    description { Faker::Lorem.sentence }
  end
end
