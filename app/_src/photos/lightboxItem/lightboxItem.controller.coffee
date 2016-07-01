photosApp.controller 'LightboxItemCtrl', [
  '$scope',
  'index',
  'album',
  'Albums',
  ($scope, index, album, Albums) ->
    $scope.itemsClass = 'lightbox-item'
    $scope.photo = album.images[index]
    $scope.direction = Albums.getAdjacent(album, index)
]