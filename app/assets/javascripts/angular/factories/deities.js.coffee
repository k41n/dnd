angular.module("dndApp")
.factory "Deity", ($resource) ->
    $resource "/api/deities/:id",
    { id: "@id"},
    { update: { method: "PUT" }},
    { delete: { method: "DELETE" }}
