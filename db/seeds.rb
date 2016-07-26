20.times do
  User.create(
    first_name:   Faker::Name.first_name,
    last_name:    Faker::Name.last_name,
    sex:          %w(m w).sample,
    birth_date:   Faker::Date.between(60.years.ago, 10.years.ago),
    category:     %w(youth adults).sample,
    type:         %w(competition amateur).sample,
    rankings:     %w(a b c d j).sample,
    phone_number: Faker::PhoneNumber.phone_number,
    active:       Faker::Boolean.boolean,
    address:      Faker::Address.street_address,
    postalcode:   Faker::Address.postcode,
    city:         Faker::Address.city,
    country:      Faker::Address.country_code,
    role:         :member
  )
end
