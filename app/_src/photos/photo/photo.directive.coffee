photosApp.directive 'mfphoto', () ->
  restrict: 'E'
  replace: true
  scope: {
    photo: "="
    album: "="
  }
  templateUrl: '/js/photos/photo/photo-template.html'