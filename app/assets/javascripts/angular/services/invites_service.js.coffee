class window.Invites
  constructor: (@Invite, @Faye) ->
    @Invite.query {}, (data) =>
      @invites = {}
      for invite in data
        @invites[invite.id] = invite
    @subscribeToFaye()

  invitesNumber: ->
    return 0 unless @invites?
    Object.keys(@invites).length

  accept: (invite) ->
    console.log 'accepting invite', invite
    new @Invite().$accept
      id: invite.id

  subscribeToFaye: ->
    if @Faye?
      @Faye.subscribe "/game_invitations", (msg) =>
        console.log 'Faye: msg = ', msg
        if msg.type == 'deleted'
          delete @invites[msg.game_invitation.id]
        if msg.type == 'created'
          @invites[msg.game_invitation.id] = msg.game_invitation


Invites.$inject = ["Invite", "Faye"]

angular.module("dndApp").service("Invites", Invites)