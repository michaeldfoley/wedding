photosApp.directive 'mfphoto', () ->
  restrict: 'E'
  replace: true
  scope: {
    photo: "="
  }
  templateUrl: '/js/photos/photo/photo-template.html'