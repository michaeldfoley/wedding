photosApp.controller 'PhotoAlbumCtrl', [
  '$scope',
  '$rootScope',
  '$routeParams',
  'Authentication',
  'FIREBASE_URL', 
  '$firebaseObject',
  '$location',
  ($scope, $rootScope, $routeParams, Authentication, FIREBASE_URL, $firebaseObject, $location) ->
    $scope.id = $routeParams.id
    
    $scope.getAlbum = () ->
      if Authentication.signedIn()
        ref = new Firebase(FIREBASE_URL + 'photos/' + $scope.id)
        photoAlbum = $firebaseObject(ref)
        
        photoAlbum.$loaded().then (data) ->
          if !data.images
            $location.path( "/" );
        
          $scope.albumClass = 'gallery-' + data.$id
          $scope.currentAlbum = data.images
    
    $rootScope.$on 'loggedin', () ->
      $scope.getAlbum()
    
    $scope.getAlbum()
]