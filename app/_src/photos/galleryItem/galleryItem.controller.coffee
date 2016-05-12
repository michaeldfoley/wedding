photosApp.controller 'GalleryItemCtrl', [
  '$scope',
  '$stateParams',
  'album',
  ($scope, $stateParams, album) ->
    $scope.id = $stateParams.id
    $scope.itemsClass = 'gallery gallery-' + $scope.id
    $scope.album = album
]