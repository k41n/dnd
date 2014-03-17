json.cache! [ resource_class.maximum(:updated_at), resource_class.count ] do
    json.array! collection.to_a do |game|
        json.partial! 'api/games/game', game: game
    end

end
