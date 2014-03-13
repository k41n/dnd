json.cache! resource_class.maximum(:updated_at) do
  json.array! collection.to_a do |character|
    json.partial! 'api/characters/character', resource: character
  end
end
