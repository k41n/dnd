angular.module("dndApp")
.factory "Monster", ($resource) ->
    $resource "/api/monsters/:id",
    { id: "@id" },
    { update: { method: "PUT" }}
