json.id             resource.id
json.name           resource.name
json.description    resource.description
json.avatar_url     resource.avatar.url(:thumb)
json.hp             resource.hp
json.ac             resource.ac
json.endurance      resource.endurance
json.reaction       resource.reaction
json.will           resource.will
json.speed          resource.speed
json.str            resource.str
json.con            resource.con
json.dex            resource.dex
json.int            resource.int
json.wis            resource.wis
json.cha            resource.cha
json.skills resource.skills do |skill|
    json.partial! 'api/skills/skill', skill: skill
end
json.weapons resource.weapons do |weapon|
    json.partial! 'api/weapons/weapon', weapon: weapon
end

