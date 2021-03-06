playlistApp.directive 'mfplaylist', ['$rootScope', 'playlist', ($rootScope, playlist) ->
    restrict: 'E'
    replace: true
      
    templateUrl: '/js/playlist/playlist/playlist-template.html'
    link: (scope, elem, attrs) ->
      playlistOptions = {
        fields: 'items(added_at,added_by(id),track(album(images),artists(name),id,external_ids,name,preview_url))'
      }
      
      scope.playlist = playlist
      
      getPlaylist = () ->
        playlist.getPlaylist(scope.playlistId.owner, scope.playlistId.id, playlistOptions)
      getPlaylist()
      
      scope.$on '$destroy', () ->
        deregister()
        
      deregister = $rootScope.$on 'song.update', (event, args) ->
        if args.type == 'remove'
          playlist.removeSong(scope.playlistId.owner, scope.playlistId.id, args.song)
          
        if args.type == 'add'
          playlist.addSong(scope.playlistId.owner, scope.playlistId.id, args.song.track)
        
  ]