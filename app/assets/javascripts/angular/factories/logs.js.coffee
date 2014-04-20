angular.module("dndApp").factory "Logs", ["$resource", ($resource) ->
    $resource "/api/logs/"
]