photosApp.controller 'GalleryCtrl', [
  '$scope',
  '$state',
  '$stateParams',
  'album',
  ($scope, $state, $stateParams, album) ->
    $scope.id = $stateParams.id
    $scope.albumClass = 'gallery-' + $scope.id
    $scope.message = album.message
    $scope.currentAlbum = album.images
]