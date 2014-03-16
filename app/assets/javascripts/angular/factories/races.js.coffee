angular.module("dndApp")
.factory "Race", ($resource) ->
    $resource "/api/races/:id",
      { id: "@id"},
      { update: { method: "PUT" }},
      { delete: { method: "DELETE" }}
