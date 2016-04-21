photosApp.directive 'mfphoto', () ->
  restrict: 'E'
  replace: true
  scope: {
    photo: "="
  }
  templateUrl: '/js/photos/photo/photo-template.html'
  compile: () ->
    pre: (scope) ->
      scope.photo.imageUrl = 'https://emandmike.firebaseapp.com/photos/' + scope.photo.src + '-medium.jpg'
      scope.photo.srcset = 'https://emandmike.firebaseapp.com/photos/' + scope.photo.src + '-small.jpg 480w, https://emandmike.firebaseapp.com/photos/' + scope.photo.src + '-medium.jpg 768w, https://emandmike.firebaseapp.com/photos/' + scope.photo.src + '-large.jpg 1200w, https://emandmike.firebaseapp.com/photos/' + scope.photo.src + '-xlarge.jpg 2000w'