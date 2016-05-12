photosApp.factory 'Albums', ($firebaseObject, FIREBASE_URL, $q) ->
  
  state = {}
  
  albums =
    get: () ->
      if Object.getOwnPropertyNames(state).length > 0
        return $q.when(state)
        
      ref = new Firebase(FIREBASE_URL + 'albums')
      photoAlbums = $firebaseObject(ref)
      photoAlbums.$loaded().then (data) ->
        return state = data
      .catch (error) ->
        return $q.reject(error)
    
    getAlbum: (albumId) ->
      albums.isAlbum(albumId).then (isAlbum) ->
        
        if !isAlbum
          return false
          
        if state[albumId].images
          return state[albumId]
        
        ref = new Firebase(FIREBASE_URL + 'photos/' + albumId)
        photoAlbum = $firebaseObject(ref)
        photoAlbum.$loaded().then (currentAlbum) ->
          state[albumId].images = currentAlbum.images
          return state[albumId]
        .catch (error) ->
          return $q.reject(error)
    
    getCurrentImage: (images, id) ->
      current = images.filter (image) ->
        image.src == id
      current[0]
    
    getImagePosition: (images, id) ->
      current = images.filter (image) ->
        image.src == id
      return images.indexOf( current[0] )
    
    getAdjacent: (album, index) ->
      direction = {}
      if index > 0
        direction['prev'] = 
          id: album.id
          photo: album.images[index - 1].src
      
      if index < album.images.length - 1
        direction['next'] = 
          id: album.id
          photo: album.images[index + 1].src
      return direction
          
    isAlbum: (albumId) ->
      albums.get().then (data) ->
        !!data[albumId]
    
    loginRequired: (albumId) ->
      albums.get().then (data) ->
        if data[albumId]
          data[albumId].login