photosApp.controller 'PhotoSingleCtrl', [
  '$scope',
  '$rootScope',
  '$routeParams',
  'Authentication',
  '$location',
  'Albums',
  ($scope, $rootScope, $routeParams, Authentication, $location, Albums) ->
    $scope.id = $routeParams.id
    photoId = $routeParams.photo
    $doc = angular.element(document)
    
    Albums.getAlbums().then (data) ->
      if !data[$scope.id]
        $location.path( "/" ).replace()
      $scope.album = data[$scope.id]
      
    Albums.getImage($scope.id, photoId).then (data)->
      if !data.current
        $location.path( "/" +  $scope.id ).replace()
      $scope.image = data
    
    keydown = (e) ->
      if (e.keyCode == 37 || e.keyCode == 38) && $scope.image.prev
        window.location.hash = "/" +  $scope.id + "/" + $scope.image.prev.src
      if (e.keyCode == 39 || e.keyCode == 40) && $scope.image.next
        window.location.hash = "/" +  $scope.id + "/" + $scope.image.next.src
      if (e.keyCode == 27 || e.keyCode == 88)
        window.location.hash = "/" +  $scope.id
    
    $doc.on 'keydown', keydown
    
    $scope.$on '$destroy', () ->
      $doc.off 'keydown', keydown
]
    
    