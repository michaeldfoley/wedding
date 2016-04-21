photosApp.controller 'PhotosCtrl', [
  '$scope',
  '$rootScope',
  '$routeParams',
  'Authentication',
  '$location',
  'Albums',
  ($scope, $rootScope, $routeParams, Authentication, $location, Albums) ->
    $scope.id = $routeParams.id
    $scope.signedIn = () ->
      Authentication.signedIn()
    
    $scope.getAlbum = () ->
      Albums.loginRequired($scope.id).then (loginRequired) ->
        if !loginRequired || $scope.signedIn()
          Albums.getAlbum($scope.id).then (data) ->
            if !data.images
              $location.path( "/" );
          
            $scope.albumClass = 'gallery-' + data.$id
            $scope.currentAlbum = data.images
        
        else
          console.log "login is required and you're not logged in"
    
    $rootScope.$on 'loggedin', () ->
      $scope.getAlbum()
    
    
]