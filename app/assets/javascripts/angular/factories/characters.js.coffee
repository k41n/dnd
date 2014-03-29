angular.module("dndApp")
.factory "CharacterAPI", ["$resource", ($resource) ->
    $resource "/api/characters/:id",
    { id: "@id" },
    { 
      update: { method: "PUT" },
      delete: { method: "DELETE" },
      invite: { method: "POST", url: "/api/characters/invite" },
      uninvite: { method: "DELETE", url: "/api/characters/uninvite" },
      kick: { method: "DELETE", url: "/api/characters/kick" }
    }
]