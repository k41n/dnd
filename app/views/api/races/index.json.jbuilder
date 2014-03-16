json.cache! [resource_class.maximum(:updated_at), resource_class.count] do
    json.array! collection.to_a do |race|
        json.partial! 'api/races/race', race: race
    end
end
