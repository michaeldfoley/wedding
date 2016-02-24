angular.module 'spotifyPlaylistCollab'
  .factory 'player', ['audio', '$rootScope', (audio, $rootScope) ->
    
    player =
      current: null
      isPlaying: false
      previewImg: null
      name: null
      artists: null
      
      play: (song) ->
        url = song.preview_url
        if player.isPlaying
          player.stop()
        if !player.isCurrent(url)
          player.current = audio.src = url
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
          $rootScope.$emit 'player.stopped'
          audio.remove()
          player.previewImg = player.current = player.name = player.artists = null
      
      hasTrack: () ->
        !!player.current
      
      isCurrent: (track) ->
        player.current && player.current == track
      
      thisIsPlaying: (track) ->
        player.isPlaying && player.isCurrent(track.preview_url)
      
      thisIsPaused: (track) ->
        !player.isPlaying && player.isCurrent(track.preview_url)
        
      toggle: (song) ->
        if typeof song == 'undefined'
          song = preview_url: player.current
        if player.isPlaying && player.isCurrent(song.preview_url)
          player.pause()
        else
          player.play(song)
    
    audio.addEventListener 'ended', () ->
      $rootScope.$apply () ->
        player.stop()
    
    return player
  ]
  