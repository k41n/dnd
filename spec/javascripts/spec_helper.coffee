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

afterEach ->
  @http.resetExpectations()
  @http.verifyNoOutstandingExpectation()
