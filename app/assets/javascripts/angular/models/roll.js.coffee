class window.Roll
  @do: (count, dice, bonus) ->
    bonus ||= 0
    sum = 0
    for i in [0..count - 1]
      roll = Math.floor(Math.random() * (dice - 1)) + 1
      console.log 'Rolled ', roll
      sum += roll
    sum + bonus