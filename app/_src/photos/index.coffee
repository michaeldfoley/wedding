photosApp = angular.module 'photos', [
  'ui.router', 
  'firebase',
  'pasvaz.bindonce',
  'ngTouch',
  'ngAnimate',
  'hj.gridify']
  
photosApp.constant 'FIREBASE_PHOTOS', '/img/gallery'
  
photosApp.config [
    '$stateProvider', 
    '$urlRouterProvider', 
    '$urlMatcherFactoryProvider', 
    '$locationProvider', 
    ($stateProvider, $urlRouterProvider, $urlMatcherFactoryProvider, $locationProvider) ->
    
      firebase.initializeApp
        apiKey: 'AIzaSyCR1jUuzOIfD2a7wITtApWGuLQNdDJudmo'
        authDomain: 'emandmike.firebaseapp.com'
        databaseURL: 'https://emandmike.firebaseio.com'
        storageBucket: 'firebase-emandmike.appspot.com'
      
      $locationProvider.html5Mode true
      $urlMatcherFactoryProvider.strictMode(false)
      $stateProvider
        .state 'albums',
          url: ''
          templateUrl: '/js/photos/albums/albums-view.html'
          controller: 'AlbumsCtrl'
          resolve:
            albums: ['Albums', (Albums) ->
              Albums.getArray()
            ]
              
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
            albums: ['Albums', (Albums) ->
              Albums.getArray()
            ]
            album: [
              '$stateParams', 
              'Albums', 
              'Authentication', 
              ($stateParams, Albums, Authentication) ->
                Albums.loginRequired($stateParams.id).then (loginRequired) ->
                  if !loginRequired || Authentication.signedIn()
                    Albums.getAlbum($stateParams.id)
                    .catch (error) ->
                      message: error
            ]
          
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
            index: [
              '$stateParams', 
              'Albums', 
              'album',
              ($stateParams, Albums, album)->
                Albums.getImagePosition(album.images, $stateParams.photo)
            ]
]  
      
photosApp.run [
    '$rootScope', 
    '$state',
    '$location',
    '$window',
    'Authentication', 
    'Albums', 
    'Df',
    ($rootScope, $state, $location, $window, Authentication, Albums, Df) ->
      Df.InitializeState()
      $rootScope.$on '$stateChangeStart', (event, toState, toParams, fromState, fromParams)->
      
        event.targetScope.pagePosish = if toState.name == 'gallery' then fromParams.photo
        
        if toParams.id
          Albums.loginRequired(toParams.id).then (loginRequired) ->
            if loginRequired && !Authentication.signedIn()
              event.targetScope.returnTo = 
                name: toState.name
                params: toParams
              $state.go('login')
      $rootScope.$on '$stateChangeSuccess', (event) ->
        $window.ga('send', 'pageview', $location.path())
]
