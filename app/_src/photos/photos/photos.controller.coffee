photosApp.controller 'PhotosCtrl', [
    '$scope',
    '$rootScope',
    'FIREBASE_URL', 
    '$firebaseArray',
    'Authentication'
    ($scope, $rootScope, FIREBASE_URL, $firebaseArray, Authentication) ->
          
      $scope.loggedin = () ->
        Authentication.signedIn()
      
      $scope.getAlbums = () -> 
        if $scope.loggedin()
          ref = new Firebase(FIREBASE_URL + 'photos')
          photoAlbums = $firebaseArray(ref)
          
          photoAlbums.$loaded().then (data) ->
            $scope.photoAlbums = data
      
      $rootScope.$on 'loggedin', () ->
        $scope.getAlbums()

  ]