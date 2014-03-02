angular.module("dndApp")
.factory "Game", ($resource) ->
    $resource "/api/games/:id",
    { id: "@id" },
    { update: { method: "PUT" }},
    { delete: { method: "DELETE" }}
