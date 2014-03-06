json.cache! resource_class.maximum(:updated_at) do
    json.array! collection.to_a
end
