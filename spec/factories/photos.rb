require 'faker'

FactoryGirl.define do
  factory :photo do
    association :user
    association :challenge
    url { Faker::Internet.url }
  end
end
