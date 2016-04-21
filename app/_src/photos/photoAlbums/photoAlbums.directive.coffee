photosApp.directive 'mfphotoalbums', ['Albums', (Albums) ->
  restrict: 'E'
  replace: true
  scope: {}
  templateUrl: '/js/photos/photoAlbums/photoAlbums-template.html'
  compile: () ->
    pre: (scope) ->
      Albums.getAlbums().then (data) ->
        scope.photoAlbums = data
      
]