#= require spec_helper

describe 'Chars', ->
  beforeEach ->
    @service = @injector.get('Chars')

    @characters = [ { id: 1, name: 'Кровавый упырь' } ]
    @http.whenGET('/api/characters').respond(200, @characters)

    @CharacterAbility = @model('CharacterAbility')
    @character_abilities = [new @CharacterAbility({id: '1', name: 'Знание улиц'})]
    @http.whenGET('/api/character_abilities').respond(200, @character_abilities)

    @Perk = @model('Perk')
    @perks = [new @Perk({ id: 1, name: 'Нечеловеческая человечность' })]
    @http.whenGET('/api/perks').respond(200, @perks)

    @Skill = @model('Skill')
    @skills = [new @Skill({ id: 1, title: 'Удар ногой с разворота' })]
    @http.whenGET('/api/skills').respond(200, @skills)

    @http.flush()

  describe 'init', ->
    it 'requests characters on init', ->
      expect(@service.characters).toBeDefined()
      expect(Object.keys(@service.characters).length).toEqual(1)

    it 'fills character permanent data', ->
      console.log @service
      expect(@service.characters[1].p.name).toEqual(@characters[0].name)