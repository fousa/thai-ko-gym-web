FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    sex { User.sexes.keys.sample }

    factory :user_with_password do
      email { Faker::Internet.email }

      some_password = Faker::Internet.password
      password some_password
      password_confirmation some_password

      confirmed_at Time.now
    end
  end
end
