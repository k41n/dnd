class window.InvitesController
  constructor: (@$scope, @Invites) ->
    @$scope.c = @

  acceptInvite: (invite) ->
    @Invites.accept(invite)

InvitesController.$inject = ["$scope", "Invites"]

angular.module("dndApp").controller("InvitesController", InvitesController)