dndApp = angular.module "dndApp"

dndApp.factory 'Faye', ['$faye', '$window', ($faye, $window) ->
  fayeHost = if $window.gon? then $window.gon.faye_host else 'http://0.0.0.0:9292/faye'
  $faye(fayeHost) if Faye?
]