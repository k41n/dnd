angular.module("dndApp")
.factory "CharacterAbility", ($resource) ->
    $resource "/api/character_abilities/:id",
      { id: "@id"},
      { update: { method: "PUT" }},
      { delete: { method: "DELETE" }}
