photosApp.controller 'LoginCtrl', [
  '$scope',
  '$state', 
  '$window',
  'Authentication', 
  ($scope, $state, $window, Authentication) ->
    $scope.user = {}
    $scope.user['email'] = 'hi@emandmike.us'
    $window.document.getElementById('password').focus()
    if $scope.returnTo && $scope.returnTo['name'] == 'gallery'
      $scope.heading = 'Please login to view this album'
    
    $scope.login = ->
      if (!$scope.user.password)
        $scope.feedback = 'Password is required.'
      else
        $scope.feedback = '';
        $scope.loading = true
        Authentication.login($scope.user)
        .then () ->
          $scope.loading = false
          if $scope.returnTo
            $state.go $scope.returnTo.name, $scope.returnTo.params
          
        .catch (error) ->
          $scope.loading = false
          $scope.feedback = error.toString()
      
]