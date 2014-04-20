dndApp = angular.module "dndApp"

dndApp.directive 'scrollDown', ["$interval", ($interval) ->
  restrict: 'AC',
  link: (scope, element) ->
    $interval ->
      element[0].scrollTop = element[0].scrollHeight
    , 1000
]