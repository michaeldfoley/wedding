photosApp.directive 'mfauthentication', ['$rootScope', 'Authentication', ($rootScope, Authentication) ->
    restrict: 'E'
    replace: true
    scope: {}
    templateUrl: '/js/photos/common/authentication-template.html'
    link: (scope, elem, attrs) ->
      scope.user = {}
      scope.user['email'] = 'hi@emandmike.us'
      scope.login = ->
        if (scope.user.password)
          scope.feedback = '';
          scope.loading = true
          Authentication.login(scope.user)
          .then () ->
            scope.loading = false
          .catch (error) ->
            scope.loading = false
            scope.feedback = error.toString()
        
  ]