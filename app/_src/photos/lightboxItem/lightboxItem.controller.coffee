photosApp.controller 'LightboxItemCtrl', [
  '$scope',
  '$rootScope',
  '$state',
  '$stateParams',
  'index',
  'album',
  'Albums',
  ($scope, $rootScope, $state, $stateParams, index, album, Albums) ->
    $scope.itemsClass = 'lightbox-item'
    $scope.photo = album.images[index]
    $scope.direction = Albums.getAdjacent(album, index)
]