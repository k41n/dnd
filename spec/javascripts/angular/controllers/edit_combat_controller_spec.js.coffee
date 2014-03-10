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
    
    @http.flush()

  describe 'load', ->
    it 'sets up the list of combats inside game', ->
      expect(@scope).toBeDefined()
      expect(@scope.combat).toBeDefined()
