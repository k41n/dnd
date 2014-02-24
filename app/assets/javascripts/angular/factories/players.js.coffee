angular.module("dndApp")
.factory "Player", ($resource) ->
    $resource "/api/players/:id",
    { id: "@id" },
    { update: { method: "PUT" }}
