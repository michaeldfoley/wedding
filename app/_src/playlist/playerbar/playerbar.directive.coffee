playlistApp.directive 'mfplayerbar', ['$rootScope', 'player', 'playlist', ($rootScope, player, playlist) ->
    restrict: 'E'
    replace: true
    scope: {
      playlistId: "=playlist"
    }
    templateUrl: '/js/playlist/playerbar/playerbar-template.html'
    link: (scope, elem) ->
      scope.toggleTrack = () ->
        player.toggle(scope.song)
      
      scope.nextTrack = ($event) ->
        if !scope.isLast
          player.toggle( playlist.nextSong(player.current).track )
        
      scope.prevTrack = ($event) ->
        if !scope.isFirst
          player.toggle( playlist.prevSong(player.current).track )
      
      scope.$on '$destroy', () ->
        deregister()
        
      deregister = $rootScope.$on 'player.update', (event, args) ->
        if args.source != 'search'
          scope.isPlaying = (args.status == 'playing')
        
        if args.source != 'search' && args.status == 'playing'
          elem.removeClass 'isPaused'
            .addClass 'isPlaying'
          
          scope.isFirst = playlist.isFirst(player.current)
          scope.isLast = playlist.isLast(player.current)
          scope.song = player.song
          scope.image = scope.song.album.images[1].url
          scope.artists = ''
      
          angular.forEach scope.song.artists, (artist, key) ->
            scope.artists += artist.name
            if key < scope.song.artists.length - 1
              scope.artists += ', '
        
          scope.$evalAsync(
            scope.player = player
          )
          
        if args.status == 'paused' || args.status == 'stopped'
          elem.removeClass 'isPlaying'
            .addClass 'isPaused'
        
  ]