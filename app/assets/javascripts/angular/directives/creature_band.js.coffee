dndApp = angular.module "dndApp"

dndApp.directive 'creatureBand', ->
  replace: true
  transclude: true
  restrict: 'E'
  controller: [ '$scope', '$element', '$attrs', ($scope, $element, $attrs) ->

    $scope.isRoundOver = ->
      $scope.actingCreature.data.name == 'Конец хода'

    $scope.actingCreature = $scope.creatureBand[0]


  ]
  templateUrl: '/creatures_band.html'
#    "<div class='creature-band'>
#       <div class='creature-band-item' ng-repeat='creature in creaturesBand' ng-class='acting': '>
#         {{ creature.data.name }}
#       </div>
#       <div class='clearfix'></div>
#     </div>"
