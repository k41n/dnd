json.cache! Monster.maximum(:updated_at) do

  json.array! @monsters.to_a do |monster|
    json.name monster.name
    json.description monster.description
    json.avatar_url monster.avatar.url(:thumb)
  end
end