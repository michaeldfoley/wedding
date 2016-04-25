photosApp.controller 'PhotosCtrl', [
  '$scope',
  '$rootScope',
  '$routeParams',
  'Authentication',
  '$location',
  'Albums',
  ($scope, $rootScope, $routeParams, Authentication, $location, Albums) ->
    $scope.id = $routeParams.id
    $scope.albumClass = 'gallery-' + $scope.id
    $scope.signedIn = () ->
      Authentication.signedIn()
    
    $scope.getAlbum = () ->
      Albums.isAlbum($scope.id).then (isAlbum) ->
        if !isAlbum
          $location.path( "/" ).replace()
        else
          Albums.getAlbum($scope.id).then (data) ->
            $scope.currentAlbum = data.album.images
            $scope.message = data.message
    
    $rootScope.$on 'loggedin', () ->
      $scope.getAlbum()
    
    
]