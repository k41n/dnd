#= require application
#= require angular_templates
#= require angular-mocks
#= require sinon
#= require jasmine-sinon

beforeEach(module('dndApp'))

beforeEach inject (_$httpBackend_, _$compile_, $rootScope, $controller, $location, $injector, $timeout, $route, $routeParams) ->
  @scope = $rootScope.$new()
  @http = _$httpBackend_
  @compile = _$compile_
  @location = $location
  @controller = $controller
  @factory = (name) =>
    @injector.get(name)
  @injector = $injector
  @timeout = $timeout
  @route = $route
  @routeParams = jasmine.createSpy('routeParamsStub')
  @model = (name) =>
    @injector.get(name)
  @eventLoop =
    flush: =>
      @scope.$digest()
  @sandbox = sinon.sandbox.create()

  @prepareSkillApis = ->
    stubApiSkills(@http)
    stubApiPerks(@http)
    stubApiWeapons(@http)
    stubApiRaces(@http)
    stubApiCharacterAbilities(@http)    
    stubApiCharacterClasses(@http)
    stubApiLogs(@http)
    stubApiMonsters(@http)
    stubApiCharacters(@http)
    @Creature = @factory('Creature')
    @CharacterModel = @factory('CharacterModel')

    @Weapons = @factory('Weapons')
    @Chars = @factory('Chars')
    @Perks = @factory('Perks')
    @Zoo = @factory('Zoo')

    @http.flush()    
    

afterEach ->
  @http.resetExpectations()
  @http.verifyNoOutstandingExpectation()


