#= require spec_helper

describe 'appDnd', ->
  it 'has properly configured routing', ->
    expect(@route.routes['/monsters'].controller).toBe('MonstersController')
    expect(@route.routes['/monsters'].templateUrl).toEqual('/monsters.html');