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
json.race_id      resource.race_id
json.character_class_id resource.character_class_id
json.armor_id     resource.armor_id
json.shield_id    resource.shield_id
json.weapon_id    resource.weapon_id
json.character_ability_ids resource.character_ability_ids
json.stat_increment_points resource.stat_increment_points
json.perk_ids     resource.perk_ids
json.skill_ids    resource.skill_ids
json.deity_id     resource.deity_id
json.perk_settings	resource.perk_settings

json.weapons resource.weapons do |weapon|
    json.partial! 'api/weapons/weapon', weapon: weapon
end
