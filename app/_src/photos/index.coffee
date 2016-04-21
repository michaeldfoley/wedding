photosApp = angular.module 'photos', [
  'ngRoute', 
  'firebase',
  'pasvaz.bindonce']
  .constant 'FIREBASE_URL', 'https://emandmike.firebaseio.com/'
  .constant 'FIREBASE_PHOTOS', 'https://emandmike.firebaseapp.com/photos'
  .config ($routeProvider) ->
    $routeProvider
      .when '/:id',
        templateUrl: '/js/photos/photos/photos-view.html'
        controller: 'PhotosCtrl'