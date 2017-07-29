playlistApp.directive 'mfplayerbar', ['$rootScope', 'player', 'playlist', ($rootScope, player, playlist) ->
    restrict: 'E'
    replace: true
    scope: {
      playlistId: "=playlist"
    }
    templateUrl: '/js/playlist/playerbar/playerbar-template.html'
    link: (scope, elem) ->
      $doc = angular.element(document)
      
      scope.toggleTrack = () ->
        player.toggle(scope.song)
      
      scope.nextTrack = () ->
        if !scope.isLast
          player.toggle( playlist.nextSong(player.current).track )
        
      scope.prevTrack = () ->
        if !scope.isFirst
          player.toggle( playlist.prevSong(player.current).track )
           
      
      keydown = (e) ->
        if e.keyCode in [32,37,39] && e.target.nodeName != "INPUT"
          e.preventDefault()
          
          if e.keyCode == 32
            if scope.player
              scope.toggleTrack()
            else
              player.toggle(playlist.firstSong().track)
              
          if e.keyCode == 37
            scope.prevTrack()
            
          if e.keyCode == 39
            scope.nextTrack()
        
      $doc.on 'keydown', keydown  
      
      scope.$on '$destroy', () ->
        deregister()
        $doc.off 'keydown', keydown
        
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