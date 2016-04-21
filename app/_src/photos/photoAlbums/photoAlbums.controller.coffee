photosApp.controller 'PhotoAlbumsCtrl', [
  '$scope', 
  'Albums', 
  ($scope, Albums) ->
    $scope.getAlbums = () -> 
      Albums.getAlbums().then (data) ->
        $scope.photoAlbums = data
]