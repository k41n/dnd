json.cache! resource_class.maximum(:updated_at) do
    json.array! collection.to_a do |skill|
        json.partial! 'api/skills/skill', skill: skill
    end
end
