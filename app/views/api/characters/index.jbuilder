json.cache! resource_class.maximum(:updated_at) do
  json.array! collection.to_a do |character|
    json.id character.id
    json.name character.name
    json.avatar_url character.avatar.url(:thumb)
  end

end
