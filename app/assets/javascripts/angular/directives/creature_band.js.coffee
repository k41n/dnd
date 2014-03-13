dndApp = angular.module "dndApp"

dndApp.directive 'creatureBand', ["CreatureBand", (CreatureBand) ->
  restrict: 'E',
  template:
    "<div>123</div>"
]