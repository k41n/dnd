json.cache! resource_class.maximum(:updated_at) do
    json.array! collection.to_a do |weapon|
        json.partial! 'api/weapons/weapon', weapon: weapon
    end
end
