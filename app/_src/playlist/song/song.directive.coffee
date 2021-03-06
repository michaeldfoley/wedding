playlistApp.directive 'mfsong', ['$rootScope', 'player', 'playlist', ($rootScope, player, playlist) ->
    restrict: 'E'
    replace: true
    scope: {
      song: "="
      playlistId: "=playlist"
    }
    templateUrl: '/js/playlist/song/song-template.html'
    link: (scope, elem, attrs) ->
      track = scope.song.track
      
      scope.song.hasPreview = !!(track.preview_url)
      scope.song.isOwner = !!(scope.song.added_by.id == $rootScope.userId && scope.playlistId)
      scope.song.hasControls = !!(scope.song.hasPreview || scope.song.isOwner)
      scope.artists = ''
      
      angular.forEach track.artists, (artist, key) ->
        scope.artists += artist.name
        if key < track.artists.length - 1
          scope.artists += ', '
      
      scope.toggleTrack = () ->
        player.toggle(track)
      
      scope.removeTrack = () ->
        elem.parent().addClass('deleting')
          .one 'webkitAnimationEnd oanimationend msAnimationEnd animationend', () ->
            playlist.removeSong(scope.playlistId.owner, scope.playlistId.id, scope.song)
            return
        return
      
      
      scope.$on '$destroy', () ->
        deregister()
        
      deregister = $rootScope.$on 'player.update', (event, args) ->
        
        scope.$evalAsync(
          scope.isPlaying = player.thisIsPlaying(track)
          scope.isPaused = player.thisIsPaused(track)
        )
  ]