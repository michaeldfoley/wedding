photosApp.controller 'LoginCtrl', [
  '$scope',
  '$state', 
  '$window',
  'Authentication', 
  ($scope, $state, $window, Authentication) ->
    buttonText = 'Login'
    buttonTextActive = 'Submitting...'
    $scope.user = {}
    $scope.user['email'] = 'hi@emandmike.us'
    $scope.feedback = {}
    $scope.buttonText = buttonText
    $window.document.getElementById('password').focus()
    if $scope.returnTo && $scope.returnTo['name'] == 'gallery'
      $scope.heading = 'Please login to view this album'
    
    $scope.login = ->
      if (!$scope.user.password)
        $scope.feedback.error = 'Password is required.'
      else
        $scope.feedback.error = '';
        $scope.buttonText = buttonTextActive
        Authentication.login($scope.user)
        .then () ->
          $scope.buttonText = buttonText
          if $scope.returnTo
            $state.go $scope.returnTo.name, $scope.returnTo.params
          else
            $state.go 'albums'
          
        .catch (error) ->
          $scope.buttonText = buttonText
          $scope.user['password'] = ''
          $scope.feedback.error = error.toString()
      
]