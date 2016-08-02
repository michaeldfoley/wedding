photosApp.controller 'GalleryItemCtrl', [
  '$scope',
  '$window',
  '$timeout',
  '$anchorScroll',
  '$animate',
  'album',
  ($scope, $window, $timeout, $anchorScroll, $animate, album) ->
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
      
    $anchorScroll.yOffset = 10
    scrollToPosish = () ->
      if $scope.pagePosish
        $anchorScroll($scope.pagePosish)
    
    $timeout(scrollToPosish, 50);
]