angular.module("dndApp")
.factory "Combats", ($resource) ->
    $resource "/api/games/:gameId/combats/:id",
    { id: "@id", gameId: "@gameId" }
.factory "Combat", ($resource) ->
    $resource "/api/combats/:id",
    { id: "@id"},
    { update: { method: "PUT" }},
    { delete: { method: "DELETE" }}
