photosApp.controller 'PhotosCtrl', [
    '$scope',
    '$rootScope',
    'Authentication',
    ($scope, $rootScope, Authentication) ->
      $scope.user = {}
      $scope.user['email'] = 'hi@emandmike.us'
      $scope.login = ->
        console.log Authentication
        Authentication.login($scope.user)
        .then (user) ->
          $rootScope.currentUser = user
          return
        .catch (error) ->
          $scope.message = error.toString()
  ]