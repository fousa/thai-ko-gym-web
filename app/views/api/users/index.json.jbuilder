json.array!(@users) do |user|
  json.extract! user, :id, :first_name, :last_name, :sex, :birth_date, :category, :type, :rankings, :phone_number, :active, :comments
  json.url user_url(user, format: :json)
end
