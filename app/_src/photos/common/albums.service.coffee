photosApp.factory 'Albums', ($firebaseObject, FIREBASE_URL, $q) ->
  
  album =
    getAlbums: () ->
      ref = new Firebase(FIREBASE_URL + 'albums')
      photoAlbums = $firebaseObject(ref)
      photoAlbums.$loaded().then (data) ->
        data
      .catch (error) ->
        return $q.reject(error)
    
    getAlbum: (albumId) ->
      ref = new Firebase(FIREBASE_URL + 'photos/' + albumId)
      photoAlbum = $firebaseObject(ref)
      
      photoAlbum.$loaded().then (album) ->
        return album
      .catch (error) ->
        return $q.reject(error)
    
    loginRequired: (albumId) ->
      album.getAlbums().then (data) ->
        data[albumId].login