playlistApp.directive 'mfsearch', ['$rootScope', 'Spotify', 'player', 'smoothScroll', ($rootScope, Spotify, player, smoothScroll) ->
    restrict: 'E'
    replace: true
    templateUrl: '/js/playlist/search/search-template.html'
    link: (scope, elem, attrs) ->
      scope.songQuery = ''
      scope.searchResults = null
      lastSearched = ''
      scope.lastResults = null
      
      scope.$on '$destroy', () ->
        deregister()
        
      deregister = $rootScope.$on 'playlist.update', (event, args) ->
        if args.type == 'add' then c = 'clear'
        scope.closeSearch(c)
      
            
      scope.scroll = ($event) ->
        options =
          duration: 200,
          easing: 'easeIn',
          offset: 60
        smoothScroll($event.target, options)
      
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
            
      scope.closeSearch = (c) ->
        if typeof(c) == 'undefined'
          c = ''
        if c.toLowerCase() == 'clear'
          scope.songQuery = ''
        scope.searchResults = null
        scope.player.stop()
  ]