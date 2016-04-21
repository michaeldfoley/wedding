photosApp = angular.module 'photos', [
  'ngRoute', 
  'firebase',
  'pasvaz.bindonce']
  .constant 'FIREBASE_URL', 'https://emandmike.firebaseio.com/'
  .config ($routeProvider) ->
    $routeProvider
      .when '/:id',
        templateUrl: '/js/photos/photos/photos-view.html'
        controller: 'PhotosCtrl'