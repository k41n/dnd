#= require spec_helper

describe 'Zoo', ->
  beforeEach ->
    @service = @injector.get('Zoo')
    @Monster = @model('Monster')
    @monsters = [new @Monster({ id: 1, name: 'Кровавый упырь' })]

    @http.whenGET('/api/monsters').respond(200, @monsters)
    @http.flush()

  describe 'init', ->
    it 'requests monsters on init', ->
      expect(@service.monsters).toBeDefined()
      expect(Object.keys(@service.monsters).length).toEqual(1)