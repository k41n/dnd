window.app = angular.module "dndApp", [
  "ngResource",
  "faye",
  "ngRoute",
  "ui.bootstrap",
  "ui.utils",
  "infinite-scroll"
]

window.app.config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]
.config(["$routeProvider", ($provider) ->
  $provider.when "/",
    templateUrl: '/dashboard.html'
    controller: 'DashboardController'
  .when "/monsters",
    templateUrl: '/monsters.html'
    controller: 'MonstersController'
  .when "/games",
    templateUrl: '/games.html'
    controller: 'GamesController'
  .when "/games/:id",
    templateUrl: '/edit_game.html'
    controller: 'EditGameController'
  .when "/games/:gameId/combats/:id/edit",
    templateUrl: '/edit_combat.html'
    controller: 'EditCombatController'
  .when "/games/:gameId/combats/:id",
      templateUrl: '/show_combat.html'
      controller: 'EditCombatController'
  .when "/grid",
    templateUrl: '/grid.html'
    controller: 'GridController'
])