# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :player do
    name Faker::Name.name
    sequence(:email) { |n| "user_#{n}@kodep.ru" }

    factory :master
  end
end
