class window.Logger
  constructor: (@Logs, @Faye) ->
    @subscribeToFaye()
    @logEntries = []

  info: (message) =>
    logEntry = new @Logs(message: message)
    logEntry.$save {}

  entries: =>
    @logEntries

  subscribeToFaye: =>
    if @Faye?
      @Faye.subscribe "/logs", (msg) =>
        console.log 'Faye: msg = ', msg
        if msg.type == 'created'
          @logEntries.push [@logEntries.length, msg.message]

Logger.$inject = ["Logs", "Faye"]

angular.module("dndApp").service("Logger", Logger)