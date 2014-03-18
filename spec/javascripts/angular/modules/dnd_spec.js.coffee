#= require spec_helper

describe 'appDnd', ->
  it 'has properly configured routing', ->
    expect(@route.routes['/games'].controller).toBe('GamesController')
    expect(@route.routes['/games'].templateUrl).toEqual('/games.html');

    expect(@route.routes['/characters'].controller).toBe('CharactersController')
    expect(@route.routes['/characters'].templateUrl).toEqual('/characters.html');

    expect(@route.routes['/invites'].controller).toBe('InvitesController')
    expect(@route.routes['/invites'].templateUrl).toEqual('/invites.html');

    expect(@route.routes['/games/:id'].controller).toBe('EditGameController')
    expect(@route.routes['/games/:id'].templateUrl).toEqual('/edit_game.html');
