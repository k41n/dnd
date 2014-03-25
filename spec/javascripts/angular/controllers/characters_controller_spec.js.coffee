#= require spec_helper

describe 'CharactersController', ->
  beforeEach ->
    @controller('CharactersController', { $scope: @scope })
    @Character = @model('Character')
    @characters = [new @Character({ id: 1, name: 'Элайя', character_ability_ids: [] })]

    @Race = @model('Race')
    @races = [new @Race({ id: 1, name: 'Гоблин' })]

    @CharacterClass = @model('CharacterClass')
    @character_classes = [new @CharacterClass({ id: '1', name: 'Паладин'})]

    @Armor = @model('Armor')
    @armors = [new @Armor({ id: '1', name: 'Шапка-ушанка'})]

    @Weapon = @model('Weapon')
    @weapons = [new @Weapon({ id: '1', name: 'Меч-кладенец'})]

    @CharacterAbility = @model('CharacterAbility')
    @character_abilities = [new @CharacterAbility({id: '1', name: 'Знание улиц'})]

    @http.whenGET('/api/races').respond(200, @races)
    @http.whenGET('/api/characters').respond(200, @characters)
    @http.whenGET('/api/character_classes').respond(200, @character_classes)
    @http.whenGET('/api/armors').respond(200, @armors)
    @http.whenGET('/api/weapons').respond(200, @weapons)
    @http.whenGET('/api/character_abilities').respond(200, @character_abilities)

    @Deity = @model('Deity')
    @deities = [new @Deity({ id: 1, name: 'Кровавый упырь' })]
    @http.whenGET('/api/deities').respond(200, @deities)

    @Perk = @model('Perk')
    @perks = [new @Perk({ id: 1, name: 'Нечеловеческая человечность' })]
    @http.whenGET('/api/perks').respond(200, @perks)

    @http.flush()

  describe 'load', ->
    it 'sets up the list of current characters', ->
      expect(Object.keys(@scope.characters).length).toEqual(1)

  describe 'new character', ->
    it 'can create new character', ->
      @scope.c.createCharacter()
      @http.whenPOST('/api/characters').respond(200, {message: 'success'})
      @http.flush()
