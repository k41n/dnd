#= require spec_helper

describe 'appDnd', ->
  it 'has properly configured routing', ->
    expect(@route.routes['/monsters'].controller).toBe('MonstersController')
    expect(@route.routes['/monsters'].templateUrl).toEqual('/monsters.html')

    expect(@route.routes['/games'].controller).toBe('GamesController')
    expect(@route.routes['/games'].templateUrl).toEqual('/games.html');

    expect(@route.routes['/games/:id'].controller).toBe('EditGameController')
    expect(@route.routes['/games/:id'].templateUrl).toEqual('/edit_game.html');
