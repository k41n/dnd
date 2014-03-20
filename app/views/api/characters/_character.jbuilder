json.id           resource.id
json.name         resource.name
json.avatar_url   resource.avatar.url(:thumb)
json.str          resource.str
json.con          resource.con
json.dex          resource.dex
json.int          resource.int
json.wis          resource.wis
json.cha          resource.cha
json.speed        resource.speed
json.level        resource.level
json.hp           resource.hp
json.max_hp       resource.max_hp
json.xp           resource.xp
json.stamina      resource.stamina
json.reaction     resource.reaction
json.will         resource.will
json.ac           resource.ac
json.stat_points  resource.stat_points

json.skills resource.skills do |skill|
    json.partial! 'api/skills/skill', skill: skill
end
json.weapons resource.weapons do |weapon|
    json.partial! 'api/weapons/weapon', weapon: weapon
end
