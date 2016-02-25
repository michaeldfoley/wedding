angular.module 'spotifyPlaylistCollab', [
  'spotify',
  'ngAria',
  'ui.unique',
  'offClick',
  'pasvaz.bindonce']
  .config [
    '$locationProvider',
    'SpotifyProvider',
    '$httpProvider',
    ($locationProvider, SpotifyProvider, $httpProvider) ->
          
      SpotifyProvider.setClientId '37026114ba074d349b5badec6bda2844'
      SpotifyProvider.setRedirectUri 'http://localhost:3000/spotify-callback.html'
      SpotifyProvider.setScope 'playlist-modify-private'
      
      $locationProvider.html5Mode true
      
      $httpProvider.interceptors.push('authHttpResponseInterceptor')
  ]