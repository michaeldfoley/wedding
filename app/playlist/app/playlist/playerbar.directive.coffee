angular.module 'spotifyPlaylistCollab'
  .directive 'mfplayerbar', ['$rootScope', 'player', 'playlist', ($rootScope, player, playlist) ->
    restrict: 'E'
    replace: true
    scope: {
      playlistId: "=playlist"
    }
    templateUrl: 'app/playlist/playerbar-template.html'
    link: (scope, elem) ->
      elem.on 'click', '.song-toggle', () ->
        player.toggle()
      
      #elem.on 'click', '.song-next', () ->
        #player.next()
      
      #elem.on 'click', '.song-prev', () ->
        #player.prev()
      
      $rootScope.$on 'player.playing', () ->
        elem.removeClass 'isPaused'
          .addClass 'isPlaying'
        scope.$apply(
          scope.player = player
        )
              
      $rootScope.$on 'player.paused', () ->
        elem.removeClass 'isPlaying'
          .addClass 'isPaused'
      
      $rootScope.$on 'player.stopped', () ->
        elem.removeClass 'isPlaying isPaused'
        scope.player = null
        
  ]