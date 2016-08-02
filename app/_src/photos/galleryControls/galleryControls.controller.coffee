photosApp.controller 'GalleryControlsCtrl', [
  '$scope',
  'albums',
  ($scope, albums) ->
    $scope.albums = albums
    $scope.$parent.activeClass = ''
]