FactoryGirl.define do
  factory :combat do
    association :game
    name Faker::Lorem.sentence
    description Faker::Lorem.paragraph
  end
end
