json.id resource.id
json.name resource.name
json.avatar_url resource.avatar.url(:thumb)
json.skills resource.skills do |skill|
    json.partial! 'api/skills/skill', skill: skill
end
json.weapons resource.weapons do |weapon|
    json.partial! 'api/weapons/weapon', weapon: weapon
end
