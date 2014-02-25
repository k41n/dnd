json.cache! Monster.maximum(:updated_at) do

  json.array! @monsters do |monster|
    json.name monster.name
  end
end