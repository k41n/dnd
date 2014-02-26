# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game do
    association :master
    name Faker::Lorem.sentence
    description Faker::Lorem.paragraph
  end
end
