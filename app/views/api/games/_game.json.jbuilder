json.id                 game.id
json.name               game.name
json.master             game.master.email
json.master_id          game.master.id
json.description        game.description
json.invitedCharacters  game.invited_characters do |character|
  json.id     character.id
end