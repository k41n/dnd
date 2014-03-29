#= require spec_helper

describe 'EditCombatController', ->
  beforeEach ->
    @routeParams.id = 1
    @Combat = @model('Combat')
    @combat = new @Combat({ id: 1, name: 'Махачка за мешок конопли в селе Соплюево' })

    @controller('EditCombatController', { $scope: @scope, $routeParams: @routeParams })

    @http.whenGET('/api/combats/1').respond(200, @combat)

    @Monster = @model('Monster')
    @monsters = [new @Monster({ id: 1, name: 'Кровавый упырь' })]
    @http.whenGET('/api/monsters').respond(200, @monsters)

    @Character = @model('CharacterAPI')
    @characters = [new @Character({ id: 1, name: 'Элайя' })]
    @http.whenGET('/api/characters').respond(200, @characters)

    @Skill = @model('Skill')
    @skills = [new @Skill({ id: 1, title: 'Удар ногой с разворота' })]
    @http.whenGET('/api/skills').respond(200, @skills)

    @CharacterAbility = @model('CharacterAbility')
    @character_abilities = [new @CharacterAbility({id: '1', name: 'Знание улиц'})]
    @http.whenGET('/api/character_abilities').respond(200, @character_abilities)

    @Perk = @model('Perk')
    @perks = [new @Perk({ id: 1, name: 'Нечеловеческая человечность' })]
    @http.whenGET('/api/perks').respond(200, @perks)

    @http.flush()

  describe 'load', ->
    it 'sets up combat inside game', ->
      expect(@scope).toBeDefined()
      expect(@scope.combat).toBeDefined()
