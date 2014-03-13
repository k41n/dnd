json.cache! [Monster.maximum(:updated_at), Monster.count] do
  json.array! @monsters.to_a do |monster|
    json.partial! 'api/monsters/monster', resource: monster
  end
end