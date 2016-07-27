FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
    sex { User.sexes.keys.sample }
    role { User.roles.keys.sample }
    active false

    factory :user_with_password do
      email { Faker::Internet.email }

      password '123123123'
      password_confirmation '123123123'

      confirmed_at Time.now
      role :admin
    end
  end
end
