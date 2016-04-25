photosApp.filter 'src', (FIREBASE_PHOTOS) ->
  
  (input, size) ->
    if size
      return FIREBASE_PHOTOS + '/' + input + '-' + size + '.jpg'
    FIREBASE_PHOTOS + '/' + input + '-medium.jpg'