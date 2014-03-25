#= require spec_helper

describe 'Perks', ->
  beforeEach ->
    @service = @injector.get('Perks')

    @Perk = @model('Perk')
    @perks = [new @Perk({ id: 1, name: 'Нечеловеческая человечность' })]
    @http.whenGET('/api/perks').respond(200, @perks)

    @http.flush()

  describe 'init', ->
    it 'requests perks on init', ->
      expect(@service.perks).toBeDefined()
      expect(Object.keys(@service.perks).length).toEqual(1)