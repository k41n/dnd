json.cache! Player.maximum(:updated_at) do

  json.array! @players do |player|
    json.name player.name
  end
end