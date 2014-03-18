dndApp = angular.module "dndApp"

dndApp.directive 'creatureBand', ->
  replace: true
  transclude: true
  restrict: 'E'
  controller: [ '$scope', '$element', '$attrs', ($scope, $element, $attrs) ->

    $scope.isRoundOver = ->
      $scope.actingCreature.data.name == 'Конец хода'

  ]
  templateUrl: '/creatures_band.html'
