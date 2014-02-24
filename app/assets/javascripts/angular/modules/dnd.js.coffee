window.app = angular.module "dndApp", [
  "ngResource",
  "faye"
]

window.app.config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]
