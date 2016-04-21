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
          $scope.message = 
            heading: 'Please Login to View This Album'
            text: 'If you do not have the password, email Mike at <a href="mailto:hi@emandmike.us">hi@emandmike.us</a>.'
    
    $rootScope.$on 'loggedin', () ->
      $scope.getAlbum()
    
    
]