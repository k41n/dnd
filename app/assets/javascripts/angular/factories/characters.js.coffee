angular.module("dndApp")
.factory "Character", ["$resource", ($resource) ->
    $resource "/api/characters/:id",
    { id: "@id" },
    { update: { method: "PUT" }},
    { delete: { method: "DELETE" }}
]