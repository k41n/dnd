angular.module("dndApp")
.factory "Invite", ["$resource", ($resource) ->
    $resource "/api/invites/:id",
    { id: "@id" },
    { 
      update: { method: "PUT" },
      delete: { method: "DELETE" },
      accept: { method: "POST", url: "/api/invites/:id/accept" },
      reject: { method: "POST", url: "/api/invites/:id/reject" }
    }
]