angular.module 'spotifyPlaylistCollab'
  .directive 'onFinishResize', ($timeout, $window)->
    restrict: 'A'
    link: (scope, element, attr) ->
      if scope.$last == true
      
        resizeTimer = null

        resizeResults = () ->
          resultsBox = element.context.parentNode
          $resultsBox = angular.element(resultsBox)
          $resultsBox.css 
            'max-height': $window.innerHeight - resultsBox.offsetTop - 80 + 'px'
          
        $window.onresize = () ->
          $timeout.cancel(resizeTimer)
          resizeTimer = $timeout(resizeResults, 250)
          return
          
        $timeout(resizeResults)
      return