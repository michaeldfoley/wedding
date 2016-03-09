angular.module 'spotifyPlaylistCollab'
  .directive 'mfprogressbar', ['$rootScope', 'audio', '$timeout', ($rootScope, audio, $timeout) ->
    restrict: 'A'
    scope: {}
    link: (scope, elem) ->
      percent = 0
      
      $rootScope.$on 'player.update', (event, args) ->
        if args.source != 'search' && args.status == 'playing'
          advance()
          return
        
        else
          $timeout.cancel(scope.timer)
          return
      
      advance = () ->
        increment = 100 / audio.duration
        timeLeft = audio.duration - audio.currentTime
        percent =  Math.min(increment * audio.currentTime, 100)
        
        if timeLeft < 0.1
          percent = 100
        
        elem.css
          width: percent + '%'
        startTimer()
        return
      
      startTimer = () ->
        if percent < 100
          scope.timer = $timeout(advance, 100)
        return
      return
        
  ]