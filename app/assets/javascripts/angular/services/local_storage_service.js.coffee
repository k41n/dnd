dndApp = angular.module "dndApp"

dndApp.factory "local_storage", [ '$window', (wnd) ->
  store: (key, value) ->
    wnd.localStorage.setItem key, JSON.stringify(value)
  ,
  retrieve: (key) ->
    JSON.parse(wnd.localStorage.getItem(key))
  ,
  delete: (key) ->
    wnd.localStorage.removeItem key
  ,
  has_key: (key) ->
    wnd.localStorage.getItem(key) != null

]