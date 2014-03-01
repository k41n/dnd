window.Tile = class
  constructor: (position, passable, terrain, figure) ->
    @row = position.row
    @col = position.col
    @passable = true
    @figure = figure
    @moveable = false
    @targetable = false