playlistApp.directive 'mffreq', ['frequency', 'audio', 'player', '$rootScope', '$timeout', (frequency, audio, player, $rootScope, $timeout) ->
    restrict: 'E'
    replace: true
    scope: {
      song: "="
    }
    templateUrl: '/js/playlist/frequency/frequency-template.html'
    link: (scope, elem, attrs) ->
      if frequency
        frequency.draw(elem, audio)
        frequency.startDrawing()
        
        scope.$on '$destroy', () ->
          playerUpdate()
          
        playerUpdate = $rootScope.$on 'player.update', (event, args) ->
          id = scope.song.track.external_ids.isrc
          
          if args.status == 'playing' && player.isCurrent(id)
            frequency.startDrawing()
            
          else if player.isCurrent(id)
            $timeout(frequency.stopDrawing, 700)
      
  ]