FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    first_name "John"
    last_name "Doe"
    password "password"
    password_confirmation "password"
  end

  factory :game do
    street "32 Main Street"
    city "Boston"
    state "MA"
    zip "01223"
    game_day "2016/05/13"
    game_time "6:00 PM"
    opponent "Wildcats"
  end
end
