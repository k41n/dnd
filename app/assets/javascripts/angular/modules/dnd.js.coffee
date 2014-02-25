window.app = angular.module "dndApp", [
  "ngResource",
  "faye",
  "ngRoute",
  "ui.bootstrap"
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
])