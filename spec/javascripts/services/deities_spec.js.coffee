#= require spec_helper

describe 'Deities', ->
  beforeEach ->
    @service = @injector.get('Deities')

    @Deity = @model('Deity')
    @deities = [new @Deity({ id: 1, name: 'Кровавый упырь' })]
    @http.whenGET('/api/deities').respond(200, @deities)

    @http.flush()

  describe 'init', ->
    it 'requests deities on init', ->
      expect(@service.deities).toBeDefined()
      expect(Object.keys(@service.deities).length).toEqual(1)