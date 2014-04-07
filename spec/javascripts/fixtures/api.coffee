window.fixtures ||= {}

window.stubApiSkills = (http) ->
  skills = [{ id: 1, title: 'Удар ногой с разворота' }]
  http.whenGET('/api/skills').respond(200, skills)

window.stubApiPerks = (http) ->
  perks = [{ id: 1, name: 'Нечеловеческая человечность' }]
  http.whenGET('/api/perks').respond(200, perks)

window.stubApiMonsters = (http) ->
  monsters = [{ id: 1, name: 'Кровавый упырь' }]
  http.whenGET('/api/monsters').respond(200, monsters)

window.stubApiWeapons = (http) ->
  weapons = [{ id: '1', name: 'Меч-кладенец', damage_dice: 8, damage_count: 1}]
  http.whenGET('/api/weapons').respond(200, weapons)  

window.stubApiRaces = (http) ->
  races = [{ id: 1, name: 'Гоблин' }]
  http.whenGET('/api/races').respond(200, races)