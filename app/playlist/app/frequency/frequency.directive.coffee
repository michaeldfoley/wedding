angular.module 'spotifyPlaylistCollab'
  .directive 'mffreq', ['frequency', 'audio', 'player', '$rootScope', (frequency, audio, player, $rootScope) ->
    restrict: 'E'
    replace: true
    scope: {
      song: "="
    }
    templateUrl: 'app/frequency/frequency-template.html'
    link: (scope, elem, attrs) ->
      frequency.draw(elem, audio)
      frequency.startDrawing()
      
      $rootScope.$on 'player.update', (event, args) ->
        id = scope.song.track.external_ids.isrc
        if args.status == 'playing' && player.isCurrent(id)
          frequency.startDrawing()
        else if player.isCurrent(id)
          frequency.stopDrawing()
  ]