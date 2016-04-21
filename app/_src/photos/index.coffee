photosApp = angular.module 'photos', ['ngRoute', 'firebase']
  .constant 'FIREBASE_URL', 'https://emandmike.firebaseio.com/'
  .config ($routeProvider) ->
    $routeProvider
      .when '/:id',
        templateUrl: '/js/photos/photoAlbum/photoAlbum-view.html'
        controller: 'PhotoAlbumCtrl'