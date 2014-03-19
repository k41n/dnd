angular.module("dndApp")
.factory "Weapon", ($resource) ->
    $resource "/api/weapons/:id",
      { id: "@id"},
      { update: { method: "PUT" }},
      { delete: { method: "DELETE" }}
