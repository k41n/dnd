#dndApp = angular.module "dndApp"
#
#dndApp.directive 'rotation', ->
#  replace: true
#  transclude: true
#  restrict: 'E'
##  controller: [ '$scope', '$element', '$attrs', ($scope, $element, $attrs) ->
##
##    $scope.hasik =
##      north: '&#8657;'
##      south: '&#8659;'
##      west: '&#8656;'
##      east: '&#8658;'
##
##  ]
#  scope:
#    rotationDirection: "@rotationDirection"
#
#  template: "<div>{{rotationDirection}}</div>"

dndApp = angular.module "dndApp"

dndApp.directive 'rotation', ->
  replace: true
  transclude: true
  restrict: 'E'
  scope:
    rotationDirection: "@rotationDirection"
#    rotationToSymbol: "@rotationToSymbol"
  controller: [ '$scope', '$element', '$attrs', ($scope, $element, $attrs) ->
    $scope.rotationToSymbol =
      north: '&#8657;'
      south: '&#8659;'
      west: '&#8656;'
      east: '&#8658;'

    $scope.rotation = 123
  ]


  template: "<div ng-bind-html='{{rotation}}'></div>"
#  templateUrl: '/rotation.html'

