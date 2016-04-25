photosApp.factory 'Albums', ($firebaseObject, FIREBASE_URL, Authentication, $q) ->
  
  album =
    getAlbums: () ->
      ref = new Firebase(FIREBASE_URL + 'albums')
      photoAlbums = $firebaseObject(ref)
      photoAlbums.$loaded().then (data) ->
        data
      .catch (error) ->
        return $q.reject(error)
    
    getAlbum: (albumId) ->
      payload =
        album: {}
        message: {}
    
      album.loginRequired(albumId).then (loginRequired) ->
        if !loginRequired || Authentication.signedIn()
          ref = new Firebase(FIREBASE_URL + 'photos/' + albumId)
          photoAlbum = $firebaseObject(ref)
          
          photoAlbum.$loaded().then (currentAlbum) ->
            payload.album = currentAlbum
            return payload
          .catch (error) ->
            return $q.reject(error)
        else
          payload.message =
            heading: 'Please Login to View This Album'
            text: 'If you do not have the password, email Mike at <a href="mailto:hi@emandmike.us">hi@emandmike.us</a>.'
          return payload
    
    getImage: (albumId, id) ->
      album.getAlbum(albumId).then (data)->
        image = 
          current: data.album.images.filter((image) ->
            image.src == id
          )[0]
        imageIndex = data.album.images.indexOf(image['current'])
        
        image['prev'] = data.album.images[ imageIndex - 1 ]
        image['next'] = data.album.images[ imageIndex + 1 ]
        
        image['neighbors'] = data.album.images.filter (image, index) ->
          index > imageIndex - 4 && index < imageIndex + 4
        return image
          
    
    isAlbum: (albumId) ->
      album.getAlbums().then (data) ->
        !!data[albumId]
    
    loginRequired: (albumId) ->
      album.getAlbums().then (data) ->
        if data[albumId]
          data[albumId].login