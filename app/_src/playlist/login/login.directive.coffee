angular.module 'spotifyPlaylistCollab'
  .directive 'mflogin', ['Spotify', '$rootScope', (Spotify, $rootScope) ->
    restrict: 'E'
    replace: true
    templateUrl: '/js/playlist/login/login-template.html'
    link: (scope, elem) ->
      scope.login = () ->
        Spotify.login()
          .then (data) ->
            $rootScope.token = data
  ]
        