#= require spec_helper

describe 'MessageBus', ->
  beforeEach ->
    @service = @injector.get('MessageBus')

  describe 'broadcast', ->
    it 'is defined', ->
      expect(@service.broadcast).toBeDefined()