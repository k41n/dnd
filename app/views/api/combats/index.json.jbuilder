json.cache! resource_class.maximum(:updated_at) do
    json.array! collection.to_a do |combat|
        json.partial! 'api/combats/combat', combat: combat
    end
end
