angular.module 'spotifyPlaylistCollab'
  .directive 'mfplayerbar', ['$rootScope', 'player', 'playlist', ($rootScope, player, playlist) ->
    restrict: 'E'
    replace: true
    scope: {
      playlistId: "=playlist"
    }
    templateUrl: 'app/playlist/playerbar-template.html'
    link: (scope, elem) ->
      elem.on 'click', '.playerbar-toggle', () ->
        player.toggle(scope.song)
      
      elem.on 'click', '.playerbar-next:not(.disabled)', () ->
        player.toggle( playlist.nextSong(player.current).track )
      
      elem.on 'click', '.playerbar-prev:not(.disabled)', () ->
        player.toggle( playlist.prevSong(player.current).track )
      
      $rootScope.$on 'player.playing', (event, args) ->
        if args != 'search'
          elem.removeClass 'isPaused'
            .addClass 'isPlaying'
          
          scope.isFirst = playlist.isFirst(player.current)
          scope.isLast = playlist.isLast(player.current)
          
          scope.song = player.song
          scope.image = scope.song.album.images[1].url
        
          scope.$evalAsync(
            scope.player = player
          )
              
      $rootScope.$on 'player.paused', () ->
        elem.removeClass 'isPlaying'
          .addClass 'isPaused'
      
      $rootScope.$on 'player.stopped', () ->
        elem.removeClass 'isPlaying'
          .addClass 'isPaused'
        
  ]