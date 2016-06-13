photosApp.filter 'src', (FIREBASE_PHOTOS) ->
  
  (input, size) ->
    size ?= "medium"
    append = if size != 'original' then '-' + size else ''
    return FIREBASE_PHOTOS + '/' + input + append + '.jpg'