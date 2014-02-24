dndApp = angular.module "dndApp"

dndApp.factory "MessageBus", [ '$rootScope', ($rootScope) ->
  broadcast: (type, args) ->
    service.messages ||= {}
    service.messages[type] = args
    $rootScope.$broadcast type

  params: (type) ->
    service.messages[type]
]