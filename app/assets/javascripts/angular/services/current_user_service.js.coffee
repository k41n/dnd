dndApp = angular.module "dndApp"

dndApp.factory "current_user", [ 'local_storage', '$http', '$window', (local_storage, $http, $window) ->
  service =
    loggedIn: ->
      !!service.currentUser

    login: (email, password) ->
      $http.post '/players/sign_in.json',
        user:
          email: email
          password: password
      .success (response) ->
        service.currentUser = response.user
        local_storage.store('currentUser', response.user)
        service.findShortUserName()


    loginLocal: ->
      if $window.gon?
        if $window.gon.player
          service.currentUser = $window.gon.player
        else
          service.currentUser = null
          local_storage.delete('currentUser')
      if local_storage.has_key 'currentUser'
        service.currentUser = local_storage.retrieve('currentUser')
        service.findShortUserName()

    isAssistant: ->
      service.currentUser && service.currentUser.role == 'assistant'

    logout: ->
      $http.delete '/players/sign_out.json'

      service.currentUser = null
      if local_storage.has_key 'currentUser'
        local_storage.delete 'currentUser'

    register: (email, password, firstname, lastname) ->
      $http.post '/players',
        user:
          email: email
          password: password
          password_confirmation: password
          firstname: firstname
          lastname: lastname
      .success (response) ->
        service.currentUser = response.user
        local_storage.store('currentUser', response.user)
        service.findShortUserName()


    findShortUserName: ->
      if service.currentUser? && service.currentUser.user_email? && service.currentUser.user_first_name
        if service.currentUser.user_email.length >= 8
          service.shortUserName = service.currentUser.user_first_name || service.currentUser.email
          if service.shortUserName.length >= 8
            service.shortUserName = service.shortUserName.substring(0, 8) + '...'
        else
          service.shortUserName = service.currentUser.email

  service
]