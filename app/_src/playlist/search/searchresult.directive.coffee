angular.module 'spotifyPlaylistCollab'
  .directive 'mfsearchresult', ['$rootScope', 'player', 'playlist', ($rootScope, player, playlist) ->
    restrict: 'AE'
    replace: true
    scope: {
      track: '='
    }
    templateUrl: '/js/playlist/search/searchresult-template.html'
    link: (scope, elem, attrs) ->
      scope.playlistId = scope.$parent.$parent.playlistId
      scope.artists = ''
      
      angular.forEach scope.track.artists, (artist, key) ->
        scope.artists += artist.name
        if key < scope.track.artists.length - 1
          scope.artists += ', '
      
      scope.addSong = (song) ->
        if scope.playlistId
          playlist.addSong(scope.playlistId.owner, scope.playlistId.id, song)
      
      scope.toggleSong = () ->
        player.toggle(scope.track, 'search')
      
      scope.$on '$destroy', () ->
        deregister()
        
      deregister = $rootScope.$on 'player.update', (event, args) ->
        scope.$evalAsync(
          scope.isPlaying = player.thisIsPlaying(scope.track)
          scope.isPaused = player.thisIsPaused(scope.track)
        )
      
      elem.find('.popularity-bar').attr('aria-valuenow', scope.track.popularity)
      if playlist.inPlaylist(scope.track.external_ids.isrc)
        elem.addClass('in-playlist')
  ]