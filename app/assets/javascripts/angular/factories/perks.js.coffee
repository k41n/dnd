angular.module("dndApp")
.factory "Perk", ($resource) ->
    $resource "/api/perks/:id",
    { id: "@id"},
    { update: { method: "PUT" }},
    { delete: { method: "DELETE" }}
