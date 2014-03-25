json.cache! [resource_class.maximum(:updated_at), resource_class.count] do
    json.array! collection.to_a do |resource|
        json.partial! 'api/perks/perk', resource: resource
    end
end
