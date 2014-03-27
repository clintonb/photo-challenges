require 'faker'

FactoryGirl.define do
  factory :photo do
    association :user
    url { Faker::Internet.url }
    association :data_source
    data_source_external_id { Faker::Number.number(10).to_s() }

    before(:create) do |photo, evaluator|
      photo.challenges = create_list(:challenge, 1)
    end
  end
end
