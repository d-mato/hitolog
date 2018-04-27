json.(person, :id, :created_at, :updated_at, :name, :sex, :encountered_at)
json.groups person.groups do |group|
  json.(group, :id, :name)
end
json.impressions person.impressions.order(updated_at: :desc) do |impression|
  json.(impression, :id, :comment, :date)
end
