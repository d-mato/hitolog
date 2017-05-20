json.(person, :id, :created_at, :updated_at, :name, :sex)
json.groups person.groups do |group|
  json.(group, :id, :name)
end
