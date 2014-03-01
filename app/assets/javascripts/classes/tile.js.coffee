window.Tile = class
  constructor: (position, passable, terrain, figure) ->
    @x = position.x
    @y = position.y
    @passable = true
    @figure = figure