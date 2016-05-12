photosApp.controller 'LightboxListCtrl', [
  '$scope',
  '$stateParams',
  'index',
  'album'
  ($scope, $stateParams, index, album) ->
    $scope.album = album
    $scope.listClass = 'lightbox-morelist'
    
    $scope.isActive = (photo) ->
      photo == album.images[index]
    
    photoList = (pos) ->
      if typeof pos == 'undefined'
        pos = index
      album.images.filter (image, index) ->
        index > pos - 4 && index < pos + 4
    $scope.photoList = photoList()
    
    morePhotos = ()->
      begin = album.images.indexOf($scope.photoList[0])
      end = album.images.indexOf($scope.photoList[ $scope.photoList.length - 1 ])
      return {
        begin: begin
        end: end
        prev: begin > 0
        next: end < album.images.length - 1
      }
    $scope.morePhotos = morePhotos()
    
    $scope.listAdvance = (direction) ->
      console.log 'advance'
      if direction == 'prev'
        $scope.photoList = photoList(Math.max($scope.morePhotos.begin, 0))
        $scope.morePhotos = morePhotos()
      else
        $scope.photoList = photoList(Math.min($scope.morePhotos.end, album.images.length - 1))
        $scope.morePhotos = morePhotos()
    
]