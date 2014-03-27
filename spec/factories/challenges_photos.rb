require 'faker'

FactoryGirl.define do
  factory :challenges_photos do
    association :challenge
    association :photo
  end
end
