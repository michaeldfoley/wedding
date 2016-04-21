photosApp.filter 'src', (FIREBASE_PHOTOS) ->
  
  (input) ->
    FIREBASE_PHOTOS + '/' + input + '-medium.jpg'