#= require spec_helper

describe 'Logger', ->
  beforeEach ->
    @service = @injector.get('Logger')

  describe 'info', ->
    it 'sends log on backend to be retransmitted via Faye', ->
      expect(@service.info).toBeDefined()
      @http.whenPOST('/api/logs').respond(200, {success: true})            
      @service.info('test')
      @http.flush()      