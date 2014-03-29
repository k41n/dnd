#= require spec_helper

describe 'EditGameController', ->
  beforeEach ->
    @routeParams.id = 1
    @Game = @model('Game')
    @Combat = @model('Combat')
    @game = new @Game({id: 1, name: 'ДНД №1'})

    @controller('EditGameController', { $scope: @scope, $routeParams: @routeParams })

    @combats = [new @Combat({ id: 1, name: 'Махачка за мешок конопли в селе Соплюево' })]

    @http.whenGET('/api/games/1/combats?page=1').respond(200, @combats)
    @http.whenGET('/api/games/1').respond(200, @game)

    @CharacterAPI = @model('CharacterAPI')
    @characters = [new @CharacterAPI({ id: 1, name: 'Элайя' })]

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

  describe 'load', ->
    it 'sets up the list of combats inside game', ->
      expect(@scope).toBeDefined()
      expect(Object.keys(@scope.combats).length).toEqual(1)
