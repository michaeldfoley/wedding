photosApp.controller 'GalleryItemCtrl', [
  '$scope',
  '$window',
  'album',
  ($scope, $window, album) ->
    $scope.itemsClass = 'gallery'
    $scope.album = album
    $scope.perRow = () ->
      if $window.innerWidth > 1600
        return 4
      if $window.innerWidth > 768
        return 3
      if $window.innerWidth > 480
        return 2
      return 1
]