json.cache! Player.maximum(:updated_at) do

  json.array! @players.to_a do |player|
    json.name player.name
  end
end