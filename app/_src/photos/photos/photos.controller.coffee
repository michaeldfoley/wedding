photosApp.controller 'PhotosCtrl', [
    '$scope',
    '$rootScope',
    ($scope, $rootScope) ->
          
      $scope.loggedin = () ->
        $rootScope.signedIn();
  ]