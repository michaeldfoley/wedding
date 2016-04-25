photosApp.controller 'PhotoSingleCtrl', [
  '$scope',
  '$rootScope',
  '$routeParams',
  'Authentication',
  '$location',
  'Albums',
  ($scope, $rootScope, $routeParams, Authentication, $location, Albums) ->
    $scope.id = $routeParams.id
    photoId = $routeParams.photo
    
    Albums.getAlbums().then (data) ->
      if !data[$scope.id]
        $location.path( "/" )
      $scope.album = data[$scope.id]
      
    Albums.getImage($scope.id, photoId).then (data)->
      if !data.current
        $location.path( "/" +  $scope.id)
      $scope.image = data
]
    
    