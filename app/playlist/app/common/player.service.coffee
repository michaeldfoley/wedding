angular.module 'spotifyPlaylistCollab'
  .factory 'player', ['audio', '$rootScope', (audio, $rootScope) ->
    
    player =
      current: null
      isPlaying: false
      previewImg: null
      name: null
      artists: null
      
      play: (song) ->
        songId = song.external_ids.isrc
        if player.isPlaying
          player.stop()
        if !player.isCurrent(songId)
          audio.src = song.preview_url
          player.current = songId
          player.previewImg = song.album.images[1].url
          player.name = song.name
          player.artists = song.artists
        audio.play()
        player.isPlaying = true
        $rootScope.$emit 'player.playing'
      
      pause: () ->
        if player.isPlaying
          audio.pause()
          player.isPlaying = false
          $rootScope.$emit 'player.paused'
      
      stop: () ->
        if player.isPlaying
          player.pause()
          audio.currentTime = 0
          $rootScope.$emit 'player.stopped'
      
      hasTrack: () ->
        !!player.current
      
      isCurrent: (id) ->
        player.current && player.current == id
      
      thisIsPlaying: (track) ->
        player.isPlaying && player.isCurrent(track.external_ids.isrc)
      
      thisIsPaused: (track) ->
        !player.isPlaying && player.isCurrent(track.external_ids.isrc)
        
      toggle: (song) ->
        if typeof song == 'undefined'
          song = external_ids: isrc: player.current
        if player.isPlaying && player.isCurrent(song.external_ids.isrc)
          player.pause()
        else
          player.play(song)
    
    audio.addEventListener 'ended', () ->
      $rootScope.$apply () ->
        player.stop()
    
    return player
  ]
  