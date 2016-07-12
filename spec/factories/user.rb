FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }

    some_password = Faker::Internet.password
    password some_password
    password_confirmation some_password

    confirmed_at Time.now
  end
end
