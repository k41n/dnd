json.name           resource.name
json.description    resource.description
json.avatar_url     resource.avatar.url(:thumb)
json.hp             resource.hp
json.ac             resource.ac
json.dex            resource.dex
json.skills resource.skills do |skill|
    json.partial! 'api/skills/skill', skill: skill
end

