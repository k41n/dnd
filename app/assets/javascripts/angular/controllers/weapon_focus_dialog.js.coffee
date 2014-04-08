dndApp = angular.module 'dndApp'

dndApp.controller 'WeaponFocusDialog', ['$scope', '$modalInstance', ($scope, $modalInstance) ->
  $scope.form = 
    weapon_group: ''

  $scope.weapon_groups = [
    'Арбалет',
    'Булава',
    'Древковое оружие',
    'Клевец',
    'Копье',
    'Легкий клинок',
    'Лук',
    'Молот',
    'Посох',
    'Праща',
    'Топор',
    'Тяжелый клинок',
    'Цеп'
  ]

  $scope.ok = ->
    $modalInstance.close $scope.form

  $scope.cancel = ->
    $modalInstance.dismiss 'cancel'
]
