json.set! :presence do
  json.id @presence.id
  json.present_at @presence.present_at
  
  json.registered_by do
    json.id @presence.registered_by.id
    json.name @presence.registered_by.name
  end

  json.user do
    json.id @presence.user.id
    json.name @presence.user.name
  end
end
