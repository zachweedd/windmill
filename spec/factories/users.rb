FactoryGirl.define do
  factory :user do
    username 'test_user'
    email 'test@test.com'
    password 'password'
    password_confirmation 'password'
  end

  trait :confirmed do
    after(:build) do |user|
      user.confirm
      user.save
    end
  end
end
