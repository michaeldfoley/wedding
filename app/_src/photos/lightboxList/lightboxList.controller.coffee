photosApp.controller 'LightboxListCtrl', [
  '$scope',
  '$stateParams',
  'index',
  'album',
  'Albums',
  ($scope, $stateParams, index, album, Albums) ->
    $scope.album = album
    
    $scope.isActive = (photo) ->
      photo == album.images[index]
    
    $scope.photoList = (pos) ->
      if typeof pos == 'undefined'
        pos = index
      album.images.filter (image, index) ->
        index > pos - 4 && index < pos + 4
    
]