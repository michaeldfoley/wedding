angular.module 'spotifyPlaylistCollab'
  .factory 'playlist', ['$rootScope', 'Spotify', '$filter', ($rootScope, Spotify, $filter) ->
    
    resetToken = ()->
      $rootScope.token = ''
      localStorage.setItem('spotify-token', '')
    
    getPlaylistCount = (playlistOwner, playlistId) ->
      if $rootScope.token
        Spotify.getPlaylistTracks(playlistOwner, playlistId, {fields:'total'})
          .then (data) ->
            return data      
          , (e) ->
            if e.error.status == 401
              resetToken()
    
    songsUpdated = (type, song) ->
      $rootScope.$emit 'songs.update',
        type: type
        song: song
       
    playlist =
    
      getUserId: () ->
        if $rootScope.token
          Spotify.getCurrentUser()
            .then (data) ->
              $rootScope.userId = data.id
      
      songIds: []
      
      getPlaylist: (playlistOwner, playlistId, playlistOptions) ->
        orderByDate = (a,b) ->
          if a.added_at < b.added_at then -1
          else if a.added_at > b.added_at then 1
          else 0
        
        if $rootScope.token
          playlist.getUserId()
          # If more than 100 tracks just take the last 100.
          getPlaylistCount(playlistOwner, playlistId)
            .then (count) ->
              if count
                playlistOptions.offset = if count.total > 100 then count.total - 100 else 0
                Spotify.getPlaylistTracks(playlistOwner, playlistId, playlistOptions)
                  .then (data) ->
                    playlist.songs = data.items
                    playlist.songs.sort(orderByDate)
                    playlist.songIds = []
                    angular.forEach(playlist.songs, (item, key) ->
                      playlist.songIds.push(item.track.external_ids.isrc)
                    )
                  , (e) ->
                    if e.error.status = 401
                      resetToken()
              
           
      inPlaylist: (value) ->
        playlist.songIds.indexOf(value) > -1
      
      isFirst: (id) ->
        playlist.songIds.indexOf(id) == playlist.songIds.length - 1
      
      isLast: (id) ->
        playlist.songIds.indexOf(id) == 0
      
      addSong: (playlistOwner, playlistId, track) ->
        if $rootScope.token && !playlist.inPlaylist(track.external_ids.isrc)
          playlistItem = {added_at: $filter('date')(Date.now(), 'yyyy-MM-ddTHH:mm:ss', 'UTC') + 'Z', added_by: {id: $rootScope.userId}, track: track}
          
          playlist.songs.push(playlistItem)
          playlist.songIds.push(track.external_ids.isrc)
          Spotify.addPlaylistTracks(playlistOwner, playlistId, track.id)
            .then () ->
              songsUpdated('add', playlistItem)
            
      removeSong: (playlistOwner, playlistId, song) ->
        if song.added_by.id == $rootScope.userId
          playlist.songs.splice(playlist.songs.indexOf(song), 1)
          playlist.songIds.splice(playlist.songIds.indexOf(song.track.external_ids.isrc), 1)
          
          Spotify.removePlaylistTracks(playlistOwner, playlistId, song.track.id)
            .then () ->
              songsUpdated('remove', song)
        
      nextSong: (id) ->
        position = playlist.songIds.indexOf(id) - 1
        # if the next song doesn't have a preview find one that does
        while !playlist.songs[position].hasPreview
          position--
        playlist.songs[position]
      
      prevSong: (id) ->
        position = playlist.songIds.indexOf(id) + 1
        # if the next song doesn't have a preview find one that does
        while !playlist.songs[position].hasPreview
          position++
        playlist.songs[position]
        
            
    return playlist
  ]
  