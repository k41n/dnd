#= require spec_helper
#= require fixtures/api

describe 'EditCombatController', ->
  beforeEach ->
    @routeParams.id = 1
    @Combat = @model('Combat')
    @combat = new @Combat({ id: 1, name: 'Махачка за мешок конопли в селе Соплюево' })

    @subject = @controller('EditCombatController', { $scope: @scope, $routeParams: @routeParams })

    @http.whenGET('/api/combats/1').respond(200, @combat)

    @Character = @model('CharacterAPI')
    @characters = [new @Character({ id: 1, name: 'Элайя' })]
    @http.whenGET('/api/characters').respond(200, @characters)

    @CharacterAbility = @model('CharacterAbility')
    @character_abilities = [new @CharacterAbility({id: '1', name: 'Знание улиц'})]
    @http.whenGET('/api/character_abilities').respond(200, @character_abilities)

    stubApiPerks(@http)
    stubApiWeapons(@http)
    stubApiRaces(@http)
    stubApiSkills(@http)
    stubApiMonsters(@http)
    stubApiCharacterClasses(@http)

    @http.flush()

  describe 'load', ->
    it 'sets up combat inside game', ->
      expect(@scope).toBeDefined()
      expect(@scope.combat).toBeDefined()
