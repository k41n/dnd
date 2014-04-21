window.fixtures ||= {}

window.stubApiSkills = (http) ->
  skills = [
    { id: 1, title: 'Удар ногой с разворота' },
    { id: 10, title: 'Ответный удар (реакция)', js_class: 'Skills.CounterstrikeOnAttack', attack_char_from: 'str', attack_char_to: 'ac' }
  ]
  http.whenGET('/api/skills').respond(200, skills)

window.stubApiPerks = (http) ->
  perks = [{ id: 1, name: 'Нечеловеческая человечность' }]
  http.whenGET('/api/perks').respond(200, perks)

window.stubApiMonsters = (http) ->
  monsters = [{ id: 1, name: 'Кровавый упырь' }]
  http.whenGET('/api/monsters').respond(200, monsters)

window.stubApiWeapons = (http) ->
  weapons = [
    { id: '1', name: 'Меч-кладенец', damage_dice: 8, damage_count: 1, weapon_group_name: 'Тяжелые клинки'},
    { id: '2', name: 'Игла', damage_dice: 4, damage_count: 1, weapon_group_name: 'Легкие клинки'}
  ]
  http.whenGET('/api/weapons').respond(200, weapons)  

window.stubApiRaces = (http) ->
  races = [{ id: 1, name: 'Гоблин' }]
  http.whenGET('/api/races').respond(200, races)

window.stubApiCharacterClasses = (http) ->
  character_classes = [{ id: '1', name: 'Паладин'}, { id: '2', name: 'Плут'}]
  http.whenGET('/api/character_classes').respond(200, character_classes)

window.stubApiCharacterAbilities = (http) ->
  character_abilities = [{id: '1', name: 'Знание улиц'}]
  http.whenGET('/api/character_abilities').respond(200, character_abilities)

window.stubApiLogs = (http) ->
  http.whenPOST('/api/logs').respond(200, {success: true})  