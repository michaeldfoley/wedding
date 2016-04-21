photosApp.directive 'mfphotoalbums', ['$rootScope', ($rootScope) ->
    restrict: 'E'
    replace: true
    scope: {
      album: "="
    }
    templateUrl: '/js/photos/photoAlbums/photoAlbums-template.html'
  ]