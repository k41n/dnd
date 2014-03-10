#= require spec_helper

describe 'Cell', ->
  beforeEach ->
    @cell = new Cell()

  describe 'save, load', ->
    it 'can saveload fromto JSON', ->
      @cell.moveability = 1
      json = @cell.saveToJSON()

      @cell2 = new Cell()
      @cell2.loadFromJSON(json)

      expect(@cell2.moveability).toEqual(1)


