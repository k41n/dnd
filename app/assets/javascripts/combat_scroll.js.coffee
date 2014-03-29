window.CombatScroll = class CombatScroll
  constructor: (@text, @color, @position) ->

  act: ->
    if @position
      cell = $("*[data-id=#{@position.x}#{@position.y}]")
      if cell?
        showAtPosition = cell.offset()
        if showAtPosition?
          combatScroll = $("<div class='combat-scroll'>#{@text}</div>").appendTo('body')
          combatScroll.css('left', showAtPosition.left)
          combatScroll.css('top', showAtPosition.top)
          combatScroll.css('color', @color)
          leftOffset = Math.random() * (50 - (-50)) + (-50)
          combatScroll.animate({ top: "-=40px", opacity: '1', left: "-=#{leftOffset}" }, 1000, ->
            combatScroll.animate({opacity: '0', top: "+=40px"}, 1000, ->
              combatScroll.remove()
            )
          );
