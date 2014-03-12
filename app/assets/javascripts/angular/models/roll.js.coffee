class window.Roll
  @do: (dice, count, bonus) ->
    sum = 0
    for i in [0..count - 1]
      roll = Math.floor(Math.random() * (dice - 1)) + 1
      console.log 'Rolled ', roll
      sum += roll
    sum + ( bonus || 0 )