playlistApp = angular.module 'spotifyPlaylistCollab', [
  'spotify',
  'ngAria',
  'smoothScroll',
  'ui.unique',
  'offClick',
  'pasvaz.bindonce']
  .config [
    '$locationProvider',
    'SpotifyProvider',
    ($locationProvider, SpotifyProvider) ->
          
      SpotifyProvider.setClientId '37026114ba074d349b5badec6bda2844'
      SpotifyProvider.setRedirectUri window.location.protocol + '//' + window.location.hostname + (if window.location.port then ':' + window.location.port else '') + '/spotify-callback.html'
      SpotifyProvider.setScope 'playlist-modify-private'
      
      $locationProvider.html5Mode true
  ]