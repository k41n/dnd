FactoryGirl.define do
  factory :skill do
    sequence(:title)      { |n| "Skill_#{n}" }
    sequence(:js_class)   { |n| "Attack_#{n}" }
  end
end
