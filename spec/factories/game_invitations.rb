# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :game_invitation do
    game
    character
  end
end
