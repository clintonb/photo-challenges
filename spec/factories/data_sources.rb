FactoryGirl.define do
  factory :data_source do
    # Using a number instead of word to avoid unique key violations
    name { Faker::Number.number(10).to_s() }
  end
end
