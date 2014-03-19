angular.module("dndApp")
.factory "CharacterClass", ($resource) ->
    $resource "/api/character_classes/:id",
      { id: "@id"},
      { update: { method: "PUT" }},
      { delete: { method: "DELETE" }}
