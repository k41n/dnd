dndApp = angular.module "dndApp"

dndApp.directive 'autoFocus', ["$timeout", ($timeout) ->
  restrict: 'AC',
  link: (scope, element) ->

    $timeout ->
      element[0].focus()
    , 200
]