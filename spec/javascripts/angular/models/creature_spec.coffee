#= require spec_helper

describe 'Creature', ->
  beforeEach ->
    @creature = @model('Creature')

  describe 'constructor', ->
    it 'creates creature', ->
      expect(@creature).toBeDefined()
