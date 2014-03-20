angular.module("dndApp")
.factory "Armor", ($resource) ->
    $resource "/api/armors/:id",
      { id: "@id"},
      { update: { method: "PUT" }},
      { delete: { method: "DELETE" }}
