json.cache! Monster.maximum(:updated_at) do

  json.array! @monsters do |monster|
    json.name monster.name
    json.description monster.description
    json.avatar_url monster.avatar.url(:thumb)
  end
end