photosApp.controller 'AlbumsCtrl', [
  '$scope',
  'albums',
  ($scope, albums) ->
    $scope.albums = albums
]