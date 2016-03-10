angular.module 'spotifyPlaylistCollab'
  .directive 'mfalert', ['$rootScope', '$timeout', ($rootScope, $timeout) ->
    restrict: 'E'
    replace: true
    scope:{}
    templateUrl: '/js/playlist/alert/alert-template.html'
    link: (scope, elem, attrs) ->
      scope.alerts = []
        
      alert = {
        add: (msg, style, song, type) ->
          scope.alerts.push({
            id: song.track.id
            msg: msg
            style: style
            song: song
            type: type
          })
          
        remove: (id) ->
          scope.alerts.splice(scope.alerts.indexOf(id), 1)
          
          
        clearAll: () ->
          scope.alerts = []
      }
      
      scope.undo = (alert) ->
        if alert.type == 'add'
          type = 'remove'
        else
          type = 'add'
          
        $rootScope.$emit 'song.update', 
            type: type
            song: alert.song
      
      scope.$on '$destroy', () ->
        deregister()
        
      deregister = $rootScope.$on 'playlist.update', (event, args) ->
        track = args.song.track
        alert.clearAll()
        
        if args.type == 'add'
          alert.add('Added ' + track.name + '.', 'alert-default', args.song, args.type)
          
          
        if args.type == 'remove'
          alert.add('Removed ' + track.name + '.', 'alert-default', args.song, args.type)
        
        $timeout.cancel(scope.startTimer)
        scope.startTimer = $timeout(
          () ->
            elem.find('.alert').addClass('alert-removing')
            .one 'webkitAnimationEnd oanimationend msAnimationEnd animationend', () ->
              alert.clearAll()
              @remove()
              return
            return
          , 5000 )
        
  ]