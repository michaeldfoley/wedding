angular.module 'spotifyPlaylistCollab'
  .directive 'mfsearch', ['$rootScope', '$window', 'Spotify', 'playlist', 'smoothScroll', ($rootScope, $window, Spotify, playlist, smoothScroll) ->
    restrict: 'E'
    replace: true
    templateUrl: '/js/playlist/search/search-template.html'
    link: (scope, elem, attrs) ->
      scope.songQuery = ''
      scope.searchResults = null
      lastSearched = ''
      scope.lastResults = null
      scope.playlist = playlist
      
      $rootScope.$on 'songs.update', (event, args) ->
        scope.closeSearch()
        if args.type == 'add' then scope.songQuery = ''
      
            
      elem.on 'click', '#songQuery', () ->
        options =
          duration: 200,
          easing: 'easeIn',
          offset: 60
        smoothScroll(this, options)
      
      scope.addSong = (song) ->
        if scope.playlistId
          playlist.addSong(scope.playlistId.owner, scope.playlistId.id, song)
      
      scope.search = () ->
        if scope.songQuery.length < 3
          scope.searchResults = null
          
        else if scope.songQuery != lastSearched
          Spotify.search(scope.songQuery+'*', 'track')
            .then (data) ->
              scope.searchResults = data.tracks
              scope.lastResults = data.tracks
        
        else
          scope.searchResults = scope.lastResults
          
        
        lastSearched = scope.songQuery
            
      scope.closeSearch = () ->
        scope.searchResults = null
        scope.player.stop()
  ]