angular.module("dndApp")
.factory "Skill", ($resource) ->
    $resource "/api/skills/:id",
      { id: "@id"},
      { update: { method: "PUT" }},
      { delete: { method: "DELETE" }}
