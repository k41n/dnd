#= require spec_helper

describe 'Invites', ->
  beforeEach ->
    @service = @injector.get('Invites')
    @Invite = @model('Invite')
    @invites = [new @Invite({ id: 1, game: 'Махачка за пузырь' })]

    @http.whenGET('/api/invites').respond(200, @invites)
    @http.flush()

  describe 'init', ->
    it 'requests invites on init', ->
      expect(@service.invites).toBeDefined()
      expect(Object.keys(@service.invites).length).toEqual(1)