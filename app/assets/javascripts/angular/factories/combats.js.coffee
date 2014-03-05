angular.module("dndApp")
.factory "Combat", ($resource) ->
    $resource "/api/games/:gameId/combats/:id",
    { id: "@id", gameId: "@gameId" },
    { update: { method: "PUT" }},
    { delete: { method: "DELETE" }}
