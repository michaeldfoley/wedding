photosApp.controller 'LightboxItemCtrl', [
  '$scope',
  '$rootScope',
  '$stateParams',
  'index',
  'album',
  'Albums',
  ($scope, $rootScope, $stateParams, index, album, Albums) ->
    $scope.sectionClass = 'lightbox-item'
    $scope.photo = album.images[index]
    $scope.direction = Albums.getAdjacent(album, index)
    
]