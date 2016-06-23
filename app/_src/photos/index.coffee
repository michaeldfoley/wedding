photosApp = angular.module 'photos', [
  'ui.router', 
  'firebase',
  'pasvaz.bindonce',
  'ngTouch',
  'ngAnimate']
  .constant 'FIREBASE_URL', 'https://emandmike.firebaseio.com/'
  .constant 'FIREBASE_PHOTOS', 'https://emandmike.firebaseapp.com/photos'
  .config ($stateProvider, $urlRouterProvider, $urlMatcherFactoryProvider) ->
    $urlMatcherFactoryProvider.strictMode(false)
    $stateProvider
      .state 'albums',
        url: ''
        templateUrl: '/js/photos/albums/albums-view.html'
        controller: 'AlbumsCtrl'
        resolve:
          albums: (Albums) ->
            Albums.get()
            
      .state 'login',
        url: '/login'
        views:
          '':
            templateUrl: '/js/photos/login/login-view.html'
            controller: 'LoginCtrl'
        
      .state 'gallery',
        url: '/:id'
        views:
          '':
            templateUrl: '/js/photos/gallery/gallery-view.html'
            controller: 'GalleryCtrl'
          'items@gallery':
            templateUrl: '/js/photos/galleryItem/galleryItem-view.html'
            controller: 'GalleryItemCtrl'
          'controls@gallery': 
            templateUrl: '/js/photos/galleryControls/galleryControls-view.html'
            controller: 'GalleryControlsCtrl'
        resolve: 
          albums: (Albums) ->
            Albums.get()
          album: ($stateParams, Albums) ->
            Albums.getAlbum($stateParams.id)
            .catch (error) ->
              message: error
        
      .state 'gallery.lightbox', 
        url: '/:photo'
        views:
          'items@gallery': 
            templateUrl: '/js/photos/lightboxItem/lightboxItem-view.html'
            controller: 'LightboxItemCtrl'
          'controls@gallery': 
            templateUrl: '/js/photos/lightboxControls/lightboxControls-view.html'
            controller: 'LightboxControlsCtrl'
          'list@gallery': 
            templateUrl: '/js/photos/lightboxList/lightboxList-view.html'
            controller: 'LightboxListCtrl'
        resolve:
          index: ($stateParams, Albums, album)->
            Albums.getImagePosition(album.images, $stateParams.photo)
        
  .run ($rootScope, $state, Authentication, Albums, Df) ->
    Df.InitializeState()
    $rootScope.$on '$stateChangeStart', (event, toState, toParams)->
        
      event.targetScope.activeClass = ''
      if toParams.photo
        event.targetScope.activeClass = 'lightbox'
      if toParams.id
        Albums.loginRequired(toParams.id).then (loginRequired) ->
          if loginRequired && !Authentication.signedIn()
            event.targetScope.returnTo = 
              name: toState.name
              params: toParams
            $state.go('login')
          