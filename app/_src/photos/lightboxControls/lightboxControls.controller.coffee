photosApp.controller 'LightboxControlsCtrl', [
  '$scope',
  '$rootScope',
  '$state',
  'index',
  'album',
  'Albums',
  ($scope, $rootScope, $state, index, album, Albums) ->
    $doc = angular.element(document)
    $scope.album = album
    $scope.direction = Albums.getAdjacent(album, index)
    $scope.current = album.images[index]
    
    $scope.prev = () ->
      $state.go('gallery.lightbox', $scope.direction['prev'])
    $scope.next = () ->
      $state.go('gallery.lightbox', $scope.direction['next'])
    
    keydown = (e) ->
      if (e.keyCode == 37 || e.keyCode == 38) && index > 0
        $scope.prev()
      if (e.keyCode == 39 || e.keyCode == 40) && index < album.images.length - 1
        $scope.next()
      if (e.keyCode == 27 || e.keyCode == 88)
        $state.go('gallery', {id: album.id})
    $doc.on 'keydown', keydown
    
    unWatch = $rootScope.$on '$stateChangeStart', (event, toState, toParams)->
      if !toParams.photo
        $scope.$parent.animateClass = ''
      else if Albums.getImagePosition(album.images, toParams.photo) < index
        $scope.$parent.animateClass = 'lightbox-prev'
      else
        $scope.$parent.animateClass = 'lightbox-next'
    
    $scope.$on '$destroy', () ->
      unWatch()
      $doc.off 'keydown', keydown
]